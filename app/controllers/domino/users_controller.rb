class Domino::UsersController < DominoController

  include Domino::UsersHelper

  def index
  end

  def show
    @user = User.find_by_id params[:id]
    #User.all.each do |u|
      #  unless u.avatar
      #u.avatar = 'no_avatar.jpg'
      #u.save!
    #end
  end

  def edit
    @user = User.find_by_id params[:id]
  end

  def update
    @user = User.find_by_id params[:id]
    if @user.update_edited(params[:user])
      redirect_to domino_user_path(@user.id)
    else
      render :edit
    end

  end

end
