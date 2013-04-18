# -*- encoding : utf-8 -*-

class DominoGame::Market < Array
  include Enumerable

  attr_accessor :bones

  def initialize(game)
    @game = game
    @bones = []
  end

  def init(bones_type = :goat)
    (0..6).each do |num1|
      (0..6).each do |num2|
        bones_type.to_sym == :goat ? push_goat_bones(num1, num2) : push_spider_bones(n1, n2)
      end
    end
    raise "too many bones!!!!" unless @bones.size == 28

    @bones.shuffle!

    replace @bones
  end

  def push_goat_bones(n1, n2)
    @bones << DominoGame::Goat::Bone.new(n1, n2) if n1 <= n2
  end

  def push_spider_bones(n1, n2)
    @bones << DominoGame::Spider::Bone.new(n1, n2) if n1 <= n2
  end

  def deal_bones
    init
    @game.players.each do |player|
      player.bones.clear
      player.draw_bones_from_market
    end
  end

  def to_s
    join '|'
  end

  def from_s s
    array = []
    s.split('|').each do |bone_id|
      nums = bone_id.split('-')
      array << DominoGame::Goat::Bone.new(nums.first, nums.last)
    end
    replace array
  end

end