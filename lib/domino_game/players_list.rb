# -*- encoding : utf-8 -*-
require "./lib/domino_game/player"

class DominoGame::PlayersList < Array

  attr_accessor :finished, :array, :firster

  def initialize(game)
    @game = game
    super()
  end

  def init(player_ids)
    push *player_ids.map{|player_id| player = DominoGame::Player.new(@game); player.init(player_id); player}
    @finished = []
  end

  def by_player_id(player_id)
    find{|player| player.player_id == player_id}
  end

  def define_who_strike_first
    arr = []
    each do |pl|
      arr << pl.bones.lowest_doublebone
    end
    arr.compact!
    @firster = self[arr.index(arr.min)]
  end

  def dump
    {
        :players =>  map(&:dump),
        :finished => @finished.map { |arr| arr.map(&:player_id) },
        :firster => @firster.player_id,
    }
  end

  def load_dump(dump)
    replace dump[:players].map { |player_hash| DominoGame::Player.new(@game).load_dump(player_hash) }
    @finished = dump[:finished].map{|arr| arr.map{|player_id| by_player_id(player_id)}}
    @firster = by_player_id(dump[:firster])
    self
  end

end