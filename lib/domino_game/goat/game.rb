class DominoGame::Goat::Game < DominoGame::AbstractGame

  def initialize(game)
    super(game)
    @players = DominoGame::PlayersList.new(game)
    @market = DominoGame::Market.new
  end

  def dump
    {
        :players => @players.dump,
        :bones => @market.dump
    }
  end

  def load_dump(dump)
    super(dump)
    @players.load_dump(dump[:players])
    self
  end

end