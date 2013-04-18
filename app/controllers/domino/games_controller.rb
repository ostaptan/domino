class Domino::GamesController < DominoController

  include Domino::CommonController

  before_filter :find_game, :only => [:show, :update]
  before_filter :new_game, :only => [:index, :create]
  before_filter :get_game_data, :only => [:show]

  def index
    @user = current_user
    @games = Game.available_games
    @my_current_games = current_user.games.paginate(:page => params[:page], :per_page => 10).order('id ASC')
    @my_finished_games = current_user.finished_games(params[:page]).paginate(:page => params[:page], :per_page => 10).order('id ASC')
  end

  def show
    @user = current_user
  end

  def save

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

  def find
    @params_hash = prepare_find_params(params)
    @game = Game.find_by_params(@params_hash).select {|game| game.available_sits > 0}.first
    if @game.blank?
      redirect_to_with_notice domino_games_path, t(:no_games_found)
    else
      redirect_to_with_notice domino_game_path(@game.id), t(:game_found)
    end

  end

  private

  def find_game
    @game = Game.find_by_id params[:id]
  end

  def new_game
    @game = Game.new
  end

  def prepare_find_params(params)
    {
      :min_rating => params[:min_rating],
      :max_rating => params[:max_rating],
      :time_per_move => params[:time_per_move].split(' ').first.to_i,
      :game_type => params[:game_type]
    }
  end

end
