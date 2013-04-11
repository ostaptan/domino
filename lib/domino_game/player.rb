class DominoGame::Player

  attr_accessor :bones

  def initialize(game)
    @game = game
  end

  def init(options)
    @player_id = options[:player_id]
    @bones = options[:bones] if options[:bones]
  end

  def draw_bones_from_market(num = 7)
    @bones.push(@game.market.shift(num))
  end


  def dump
    {
        :player_id => @player_id,
        :bones => @bones
    }
  end

  def self.load_dump(game, dump)
    player = create_player(game, dump[:player_id])
    player.init(dump)
    player
  end

end