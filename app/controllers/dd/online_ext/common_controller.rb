module Dd
  module OnlineExt
    module CommonController

      private

      def get_user
        @user = current_user
      end

      def get_game_data
        @game_db = DominoGame.find_by_id(params[:id])
        @game_type = @game_db.game_type
        @domino_game = DominosGame.const_get(@game_type.camelize)::Game.load_dump(@game_db.data) if @game_db && @game_db.data.present?
      end

      def save_game
        DominoGame.transaction do
          if @domino_game.finished?
            @game_db.finished_at = DateTime.now
            distribute_rating
          end

          @game_db.data = @domino_game.dump
          @game_db.save!
        end
      end

      def save_game_dump
        DominoGame.transaction do
          @game_db.data = @domino_game.dump
          @game_db.save!
        end
      end

      def distribute_rating
      end

    end
  end
end
