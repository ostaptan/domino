# -*- encoding : utf-8 -*-
require "./lib/domino_game/bone"

class DominoGame::Market < Array
  include Enumerable

  attr_accessor :bones

  def initialize(game)
    @game = game
    @bones = []
  end

  def init
    (0..6).each do |num1|
      (0..6).each do |num2|
        @bones << DominoGame::Bone.new(num1, num2) if num1 <= num2
      end
    end
    raise "too many bones!!!!" unless @bones.size == 28

    @bones.shuffle!

    replace @bones
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
      array << DominoGame::Bone.new(nums.first, nums.last)
    end
    replace array
  end

end