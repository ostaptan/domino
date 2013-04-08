module Rules
  module GameRules

    include Rules::BaseRules

    def can_create_game?(game, user)
      check_rating(game, user)

      true
    end

    def can_join_game?(game, user)
      if game.available_sits <= 0
        return false
      end

      check_rating(game, user)

      true
    end

    def can_start_game?(game)
      unless game.available_sits == 0
        return false
      end

      true
    end

    def check_rating(game, user)
      case game.game_type
        when :goat
          return false if user.g_rating < game.min_rating || user.g_rating > game.max_rating
        when :spider
          return false if user.s_rating < game.min_rating || user.s_rating > game.max_rating
        else
          return false
      end

      true
    end

  end
end