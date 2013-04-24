class AdminController < ApplicationController

  layout 'admin'

  before_filter :authorize_access

  def authorize_access
    if !logged_in? || !current_user.admin?
      redirect_to_login
      return false
    end
    true
  end

  def index

  end

  def allow?(permission, user=nil)
    user ||= current_user
    return true if user.super_admin?
    return true if user.is_user_setting?("p_#{permission.to_s}".to_sym)
    false
  end
  helper_method :allow?

  def allow_and_go?(permission)
    unless allow?(permission)
      raise "Unauthorized access to admin functionality ..."
    end
    true
  end

end