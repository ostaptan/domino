# -*- encoding : utf-8 -*-
require "./lib/domino_game/market"
require "./lib/domino_game/players_list"

class DominoGame::Goat::Game < DominoGame::AbstractGame

  attr_accessor :market, :players, :battle_field

  def initialize
    super
    @battle_field = DominoGame::Goat::BattleField.new(self)
  end

  def start(game)
    super(game)
    @battle_field.init
    self
  end

  def dump
    {
        :players => @players.dump,
        :market => @market.to_s,
        :battle_field => @battle_field.dump
    }
  end

  def load_dump(dump)
    @players.load_dump(dump[:players])
    @market.from_s(dump[:market])
    @battle_field.load_dump(dump[:battle_field])
    self
  end

end