class DominoController < ApplicationController

  before_filter :authorize_access, :except => [:logout]
  after_filter :update_online

  def index
    redirect_to(domino_user_path(current_user.id))
  end

  def authorize_access
    if logged_in?
      redirect_to admin_index_path if current_user.is_admin?
    else
      redirect_to_with_notice root_path, t(:authorization_required), :error
    end
  end

  def update_online
    current_user.update_online! if logged_in?
  end

end
