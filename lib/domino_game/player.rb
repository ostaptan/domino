# -*- encoding : utf-8 -*-
require "./lib/domino_game/player_bones"

class DominoGame::Player

  attr_accessor :bones, :player_id

  def initialize(game)
    @game = game
  end

  def init(player_id)
    @player_id = player_id
    @bones = DominoGame::PlayerBones.new(self)
    @active = true
  end

  def name
    User.find_by_id(@player_id).name
  end

  def index
    @game.players.index(self)
  end

  def get_move(bone_no)
    bone = game.take_bone_from_player(bone_no)
    DominoGame::Goat::Move.new(self, @players.current, bone)
  end

  def process_move(bone_no)
    if active?
      move = get_move(bone_no)
      move.do_move
      #after_move(move)
      #do_obvious_pickup_move
    end
  end

  def take_from_market
    @game.market.shift(1) if active?
  end

  def active?; @active end
  def disable; @active = false end

  def dump
    {
        :player_id => @player_id,
        :bones => @bones.to_s,
        :active => @active
    }
  end

  def draw_bones_from_market(count = 7)
    @bones.push(*@game.market.shift(count))
  end

  def load_dump(dump)
    @player_id = dump[:player_id]
    @bones = DominoGame::PlayerBones.new(@game).from_s(dump[:bones])
    @active = dump[:active]
    self
  end

end