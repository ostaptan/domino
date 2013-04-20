# -*- encoding : utf-8 -*-
require "./lib/domino_game/market"
require "./lib/domino_game/players_list"

class DominoGame::Goat::Game < DominoGame::AbstractGame

  attr_accessor :market, :players, :battle_field, :first_bone

  def initialize
    super
    @battle_field = DominoGame::Goat::BattleField.new(self)
  end

  def start(game)
    super(game)
    @active = true
    @first_bone = @players.firster.bones.lowest_doublebone
    self
  end

  def take_bone_from_player(bone_no)
    bone_nums_arr = bone_no.split('-')
    bone = @players.current.bones.select { |bn| bn.n1 == bone_nums_arr.first && bn.n2 == bone_nums_arr.last}
    @players.current.bones.delete bone.first
    bone.first
  end

  def take_bone_from_market(bone_no)
    bone_nums_arr = bone_no.split('-')
    bone = @market.bones.select { |bn| bn.n1 == bone_nums_arr.first && bn.n2 == bone_nums_arr.last}
    @market.bones.delete bone.first
    bone.first
  end

  def active?; @active end
  def finished?; !@active end
  def finish; @active = false end

  def dump
    {
        :players => @players.dump,
        :market => @market.to_s,
        :first_bone => @first_bone.to_s,
        :active => @active,
        :battle_field => @battle_field.dump
    }
  end

  def load_dump(dump)
    @players.load_dump(dump[:players])
    @market.from_s(dump[:market])
    @battle_field.load_dump(dump[:battle_field])
    @active = dump[:active]
    @first_bone = DominoGame::Goat::Bone.from_s dump[:first_bone]
    self
  end

end