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