class Game < ActiveRecord::Base
  # attr_accessible :title, :body

  has_and_belongs_to_many :players, :class_name => User

  GAME_TYPES = %w(goat spider)
  TIMES_PER_MOVE = 1..4
  PLAYERS_COUNT = 2..4

  def create_one!(attr, user)
    self.game_type = attr[:game_type]
    self.time_per_move = attr[:time_per_move]
    self.players_count = attr[:players_count]
    self.players << user
    self.save!
  end

  def players_count_select
    Game::PLAYERS_COUNT.map { |val| "#{val} players"}
  end

  def minutes_per_move_select
    Game::TIMES_PER_MOVE.map { |val| "#{val} minutes per move"}
  end

  def available_sits
    self.players_count - players.size
  end

  def self.available_games
    #TODO remake
    Game.all
    #Game.all :condition => [""]
  end
end
