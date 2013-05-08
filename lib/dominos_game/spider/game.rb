# -*- encoding : utf-8 -*-
require "./lib/dominos_game/market"
require "./lib/dominos_game/players_list"

class DominosGame::Spider::Game < DominosGame::AbstractGame

  attr_accessor :market, :players, :firster

  def initialize
    super
  end

  def start(game)
    super(game)
    self
  end


  def dump
    {
        :players => @players.dump,
        :market => @market.to_s
    }
  end

  def load_dump(dump)
    @players.load_dump(dump[:players])
    @market.from_s(dump[:market])
    self
  end

end