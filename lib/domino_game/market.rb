class DominoGame::Market < Array
  include Enumerable

  attr_accessor :bones

  def initialize(game)
    @game = game
    @bones = []
    super
    (0..6).each do |num1|
      (0..6).each do |num2|
        @bones << DominoGame::Bone.new(num1, num2)
      end
    end
    @bones.shuffle!

    replace @bones
  end

  def deal_bones
    begin
      deal_try
    end while !valid_deal?
  end

  def deal_try
    @game.players.each do |player|
      player.bones.clear
      player.draw_bones_from_market
    end
  end

  def valid_deal?
    @game.players.map(&:bones).all?(&:valid_for_init?)
  end

end