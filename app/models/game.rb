class Game < ActiveRecord::Base
  # attr_accessible :title, :body

  serialize :bones

  include GamesExt::Table
  include Rules::GameRules

  has_and_belongs_to_many :players, :class_name => User

  GAME_TYPES = %w(goat spider)
  TIMES_PER_MOVE = 1..4
  PLAYERS_COUNT = 2..4

  scope :find_by_params, (lambda do |params|
    { :conditions => ['rating >= ? and rating <= ? and time_per_move = ? and game_type = ?',
                      params[:min_rating], params[:max_rating], params[:time_per_move], params[:game_type]] }
  end)

  def create_one!(attr, user)
    if can_create_game?(self, user)
      self.game_type = attr[:game_type]
      self.time_per_move = attr[:time_per_move]
      self.players_count = attr[:players_count]
      self.players << user
      self.save!
    end
  end

  def join_one!(user)
    if can_join_game?(self, user)
      self.players << user
    else
      return nil
    end

    start_game!
  end

  def players_count_select
    PLAYERS_COUNT.map { |val| "#{val} players"}
  end

  def minutes_per_move_select
    TIMES_PER_MOVE.map { |val| "#{val} minutes per move"}
  end

  def available_sits
    self.players_count - players.size
  end

  def status
    available_sits == 0 ? 'Playing' : "Waiting for opponents. Available sits: #{available_sits}."
  end

  def result(user)
    self.winner_id == user.id ? 'Won' : 'Lost'
  end

  def finished
    self.finished_at.strftime('%b %d, %Y (%H:%M)') if self.finished_at
  end

  def start_game!
    if can_start_game?(self)
      case self.game_type.to_sym
        when :goat
          @goat_game = DominoGame::Goat::Game.new(self)

          self.data = @goat_game.dump
          self.started_at = DateTime.now
          self.save!
        when :spider
          @spider_game = DominoGame::Spider::Game.new(self)

          self.data = @spider_game.dump
          self.started_at = DateTime.now
          self.save!
        else
          #TODO remove
          raise 'unidentified game!'
      end
      :game_started
    else
      :wait
    end
  end

  def self.get_game(user, type)
    return user.game
  end

  def self.available_games
    self.where('started_at is ?', nil).select {|game| game.available_sits > 0}
  end
end
