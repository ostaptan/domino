module GamesExt
  module GamesMethods

    def all_games_count(type)
      case type
        when :goat
          history.g_a_lost + history.g_a_won
        when :spider
          history.s_a_lost + history.s_a_won
        else
          0
      end
    end

    def finished_games(page)
      Game.where("finished_at is not ?", nil)
    end

    def won_games_count(type)
      case type
        when :goat
          history.g_a_won
        when :spider
          history.s_a_won
        else
          0
      end
    end

    def lost_games_count(type)
      case type
        when :goat
          history.g_a_lost
        when :spider
          history.s_a_lost
        else
          0
      end
    end

    def can_do_move?(domino_game)
      self.id == domino_game.players.current.player_id
    end

  end
end