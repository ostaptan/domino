# -*- encoding : utf-8 -*-

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
      r << DominoGame::Goat::Bone.new(nums.first, nums.last)
    end
    replace r
  end

  def lowest_doublebone
    select {|bone| bone if bone.doublebone? }.sort{|x,y| x <=> y }.first
  end

end