module Domino
  module OnlineExt
    module CommonController

      private

      def get_user
        @user = current_user
      end

      def get_game_data
        @game_db = Game.find_by_id(params[:id])
        @game_type = @game_db.game_type
        @domino_game = DominoGame.const_get(@game_type.camelize)::Game.load_dump(@game_db.data) if @game_db && @game_db.data.present?
      end

      def save_game
        Game.transaction do
          if @domino_game.finished?
            @game_db.finished_at = DateTime.now
            distribute_rating
          end

          @game_db.data = @domino_game.dump
          @game_db.save!
        end
      end

      def save_game_dump
        Game.transaction do
          @game_db.data = @domino_game.dump
          @game_db.save!
        end
      end

      def distribute_rating
      end

    end
  end
end
