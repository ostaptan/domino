require 'nexmo'
class Domino::UsersController < DominoController

  include Domino::UsersHelper

  before_filter :ensure_not_guest

  def index
    @users = User.online
  end

  def show
    @user = User.find_by_id params[:id]
    @games = Game.includes(:players).available_games
    @my_current_games = current_user.games.paginate(:page => params[:page], :per_page => 10).order('id ASC')
    @my_finished_games = current_user.finished_games(params[:page]).paginate(:page => params[:page], :per_page => 10).order('id ASC')
  end

  def edit
    @user = User.find_by_id params[:id]
    if @user.birth_date
      @month = @user.birth_date.month
      @day = @user.birth_date.day
      @year = @user.birth_date.year
    end
  end

  def update
    @user = User.find_by_id params[:id]
    birth_date = DateTime.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    params[:user].merge!({:birth_date => birth_date})
    if @user.update_edited(params[:user])
      redirect_to domino_user_path(@user.id)
    else
      render :edit
    end

  end

  private

  def ensure_not_guest
    redirect_to_with_notice domino_games_path, t('notices.you_are_guest') if current_user.guest?
  end


end
