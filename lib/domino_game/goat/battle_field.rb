# -*- encoding : utf-8 -*-
# implemented as two side linked list
class DominoGame::Goat::BattleField

  attr_accessor :bones, :game, :first_bone, :table

  def initialize(game)
    @game = game
    @needed_nums = []
    @bones = []
  end

  def init
    @first_bone = @game.players.firster.bones.lowest_doublebone
  end

  def needed_nums
    unless @bones.blank?

    end
  end

  def last_right
    @bones.last
  end

  def last_left
    @bones.first
  end

  def dump
    {
        :bones => @bones.to_s,
        :first_bone => @first_bone.to_s
    }
  end

  def load_dump(dump)
    @bones.from_s(dump[:bones]) unless @bones.blank?
    @first_bone = DominoGame::Goat::Bone.from_s dump[:first_bone]
    self
  end

end