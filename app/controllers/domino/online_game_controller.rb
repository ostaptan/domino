class Domino::OnlineGameController < ApplicationController

  def handle_move
    arr = JSON.parse(params[:total_changes]) if params[:total_changes]
    arr
    respond_to do |format|
      format.js
    end
  end

end