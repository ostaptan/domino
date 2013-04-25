class Game < ActiveRecord::Base
  # attr_accessible :title, :body

  serialize :data, Hash

  include Rules::GameRules
  include Helpers::TranslateHelper
  has_and_belongs_to_many :players, :class_name => User

  GAME_TYPES = %w(goat spider)
  TIMES_PER_MOVE = 1..4
  PLAYERS_COUNT = 2..4

  scope :find_by_params, (lambda do |params|
    {:conditions => ['rating >= ? and rating <= ? and time_per_move = ? and game_type = ?',
                     params[:min_rating], params[:max_rating], params[:time_per_move], params[:game_type]]}
  end)

  def create_one!(attr, user)
    if can_create_game?(self, user)
      self.game_type = attr[:game_type]
      self.time_per_move = attr[:time_per_move]
      self.players_count = attr[:players_count]
      self.players << user
      self.rating = calculate_game_rating.to_i
      self.save!
    end
  end

  def min_rating
    (rating - rating*0.2).to_i
  end

  def max_rating
    (rating + rating*0.2).to_i
  end

  def join_one!(user)
    if can_join_game?(self, user)
      self.players << user
    else
      return nil
    end

    start_game!
  end

  def calculate_game_rating
    type = self.game_type
    case type.to_sym
      when :goat
        rat = calculate_goat_game_rating
      when :spider
        rat = calculate_spider_game_rating
      else
        raise 'unidentified game type while calculating game rating'
    end
    rat
  end

  def calculate_goat_game_rating
    self.players.size > 1 ? self.players.sum {|pl| pl.g_rating}/self.players.size : self.players.first.g_rating
  end

  def calculate_spider_game_rating
    self.players.size > 1 ? self.players.sum {|pl| pl.s_rating}/self.players.size : self.players.first.s_rating
  end

  def players_count_select
    PLAYERS_COUNT.map { |val| t('game.players', count: val)}
  end

  def minutes_per_move_select
    TIMES_PER_MOVE.map { |val| t('game.minutes_per_move', count: val) }
  end

  def available_sits
    self.players_count - players.size
  end

  def status
    available_sits == 0 ? t('games.playing') : t('games.available_sits', count: available_sits)
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
          @goat_game = DominoGame::Goat::Game.new.start(self)

          self.data = @goat_game.dump
          self.started_at = DateTime.now
          self.save!
        when :spider
          @spider_game = DominoGame::Spider::Game.new.start(self)

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

  def available?
    self.started_at.nil? && available_sits > 0
  end

  def self.available_games
    self.where('started_at is ?', nil).select { |game| game.available_sits > 0 }
  end

end
