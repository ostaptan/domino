class DominoGame::AbstractGame

  def initialize(game)
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