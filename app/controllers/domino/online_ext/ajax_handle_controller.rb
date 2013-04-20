module Domino
  module OnlineExt
    module AjaxHandleController


      def handle_move
        @domino_game.players.current.process_move(@bone_num)
        render :layout => 'online_game'
      end

      def take_from_market
        @bone = @domino_game.players.current.take_from_market.first
        @domino_game.players.current.bones << @bone
        render :layout => 'online_game'
      end

      private

      def get_bone
        @bone_num = params[:bone_num] if params[:bone_num]
      end

    end
  end
end