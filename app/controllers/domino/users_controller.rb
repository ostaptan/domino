class Domino::UsersController < DominoController

  def index
  end

  def show
    @user ||= current_user
  end

end
