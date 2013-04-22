module Domino
  module OnlineExt
    module AjaxHandleController


      def handle_move
        @domino_game.players.current.process_move(@bone_num)
        render :layout => 'online_game'
      end

      def take_from_market
        return unless current_user.can_do_move?(@domino_game)
        @bone = @domino_game.players.current.take_from_market.first
        @domino_game.players.current.bones << @bone
        respond_to do |format|
          format.html { render layout: 'online_game'}
          format.js
        end
      end

      private

      def validate_moves_turn
        redirect_to_with_notice(domino_game_path(@domino_game.id), t(:its_not_your_turn), :error) unless current_user.can_do_move?(@domino_game)
      end

      def get_bone
        @bone_num = params[:bone_num] if params[:bone_num]
      end

    end
  end
end