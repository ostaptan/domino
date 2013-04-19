# -*- encoding : utf-8 -*-
require "./lib/domino_game/player"

class DominoGame::PlayersList < Array

  attr_reader :game
  attr_accessor :finished, :firster, :nexter, :current

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
    set_firster self[arr.index(arr.min)]
  end

  def set_firster(firster)
    @firster = firster
    @nexter = player_next_to(@firster)
    @current = @firster
  end

  def player_next_to(player)
    self[ (index(player) + 1) % size ]
  end

  def current_is_firster?
    @current == @firster
  end

  def current_is_nexter?
    @current == @nexter
  end

  def set_firster_nexter
    set_firster(@defender)
  end

  def set_firster_next_to_nexter
    set_firster( player_next_to(@defender) )
  end

  def dump
    {
        :players =>  map(&:dump),
        :finished => @finished.map { |arr| arr.map(&:player_id) },
        :firster => @firster.player_id,
        :nexter => @nexter.player_id,
        :current => @current.player_id
    }
  end

  def load_dump(dump)
    replace dump[:players].map { |player_hash| DominoGame::Player.new(@game).load_dump(player_hash) }
    @finished = dump[:finished].map{|arr| arr.map{|player_id| by_player_id(player_id)}}
    @firster = by_player_id(dump[:firster])
    @nexter = by_player_id(dump[:nexter])
    @current = by_player_id(dump[:current])
    self
  end

end