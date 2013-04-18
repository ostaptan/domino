class DominoGame::AbstractGame

  def initialize
    @players = DominoGame::PlayersList.new(self)
    @market = DominoGame::Market.new(self)
  end

  def start(game)
    @game = game
    @players.init(user_ids)
    @market.deal_bones
    @players.define_who_strike_first
  end

  def user_ids
    @game.players.map { |p| p.id }
  end

  def player_ids
    @players.map { |p| p.player_id }
  end

  def player_names
    @players.map { |p| p.name }
  end

  def dump
    {}
  end

  def self.load_dump(dump)
    new.load_dump(dump)
  end

  def load_dump(dump)
    self
  end


end