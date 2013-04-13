# -*- encoding : utf-8 -*-
require "./lib/domino_game/bone"

class DominoGame::PlayerBones < Array

  attr_reader :game

  def initialize(game)
    @game = game
    super()
  end

  def to_s
    join '|'
  end

  def from_s(s)
    r = []
    s.split('|').each do |bone_id|
      nums = bone_id.split('-')
      r << DominoGame::Bone.new(nums.first, nums.last)
    end
    r
  end

end