# -*- encoding : utf-8 -*-
# bones implemented as two side linked list
class DominoGame::Goat::BattleField

  attr_accessor :bones, :game

  def initialize(game)
    @game = game
    super()
  end

  def needed_nums
    unless @bones.blank?

    end
  end

  def add_bone(bone)
    @bones.push bone
    @bones.flatten!.uniq!
  end

  def last_right
    @bones.last
  end

  def last_left
    @bones.first
  end

  def dump
    {
        :bones => @bones.to_s
    }
  end

  def load_dump(dump)
    @bones = DominoGame::PlayerBones.new(@game).from_s(dump[:bones])
    self
  end

end