class Domino::GamesController < DominoController
  before_filter :find_game, :only => [:show, :update]
  before_filter :new_game, :only => [:index, :create]

  def index
    @games = Game.available_games
    @my_current_games = current_user.games
    @my_finished_games = current_user.finished_games
  end

  def show
  end

  def create
    if @game.create_one!(params[:game], current_user)
      respond_to do |format|
        format.html { redirect_to domino_game_path(@game.id) }
      end
    else
      redirect_to_with_notice domino_games_path, t(:cant_create_game)
    end
  end

  def update
    notice = @game.join_one!(current_user)
    if notice == :wait
      respond_to do |format|
        format.html { redirect_to_with_notice domino_games_path, t(:wait_for_players) }
      end
    elsif notice == :game_started
      respond_to do |format|
        format.html { redirect_to_with_notice domino_game_path(@game.id), t(:game_started) }
      end
    else
      redirect_to_with_notice domino_games_path, t(:cant_join_game)
    end
  end

  private

  def find_game
    @game = Game.find_by_id params[:id]
  end

  def new_game
    @game = Game.new
  end

end
