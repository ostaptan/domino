class Domino::FriendshipsController < DominoController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to domino_games_path
    else
      flash[:error] = "Unable to add friend."
      redirect_to domino_user_path(params[:friend_id])
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to domino_user_path(current_user.id)
  end
end