class Game < ActiveRecord::Base
  # attr_accessible :title, :body

  serialize :bones

  include GamesExt::Table
  include Rules::GameRules

  has_and_belongs_to_many :players, :class_name => User

  GAME_TYPES = %w(goat spider)
  TIMES_PER_MOVE = 1..4
  PLAYERS_COUNT = 2..4

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

    if can_start_game?(self)
      case self.game_type
        when :goat
          DominoGame::Goat::Game.new(self)
        when :spider
          DominoGame::Spider::Game.new(self)
        else
          #TODO remove
          raise "undentified game!"
      end
      self.started_at = Time.now
      :game_started
    else
      :wait
    end
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

  def result(user)
    self.winner_id == user.id ? 'Won' : 'Lost'
  end

  def finished
    self.finished_at.strftime('%b %d, %Y (%H:%M)') if self.finished_at
  end

  def self.available_games
    self.where('started_at is ?', nil)
  end
end
