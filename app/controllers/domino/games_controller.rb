class Domino::GamesController < DominoController

  def index
    @game = Game.new
    @games = Game.available_games
    @my_current_games = current_user.games
    @my_finished_games = current_user.finished_games
  end

  def show
    @game = Game.find_by_id params[:id]
  end

  def create
    @game = Game.new
    if @game.create_one!(params[:game], current_user)
      respond_to do |format|
        format.html { redirect_to domino_game_path(@game.id) }
      end
    else
      redirect_to_with_notice domino_games_path, t(:cant_create_game)
    end
  end
end
