module DominoGames
  class PlayersList < Array

    def initialize(game)
      @game = game
    end

    def dump
      {
          :players => map(&:dump)
      }
    end

    def load_dump(dump)
      replace dump[:players].map { |player_hash| Player.load_dump(@game, player_hash) }

      self
    end

  end
end