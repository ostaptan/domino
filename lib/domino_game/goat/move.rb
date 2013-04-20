class DominoGame::Goat::Move

  attr_reader :game, :player, :bone

  def initialize(game, player, bone)
    @game = game
    @player = player
    @bone = bone
  end

  def can_move?
    is_current_player? && possible_move?
  end

  def do_move
    game.battle_field.add_bone(bone)
  end

  def take_bone

  end

  def is_current_player?
    game.players.current == player
  end

  def possible_move?
    return true if game.battle_field.needed_nums.include? bone.first
    return true if game.battle_field.needed_nums.include? bone.last

    false
  end

  #def nil_if_cannot_move
  #  can_move? ? self : nil
  #end
  #
  #def self.possible_moves(game, player)
  #  player.bones.map { |bone| new(game, player, bone).nil_if_cannot_move }.compact
  #end

end