class ApplicationController < ActionController::Base
  protect_from_forgery

  include RedisSupport

  # Authorized user
  def current_user
    return @current_user if defined?(@current_user)
    return nil if session[:user_id].blank?

    @current_user = User.find_by_id(session[:user_id])
    if @current_user #&& @current_user.adjust_attributes
      @current_user.save!
    end
    @current_user
  end

  helper_method :current_user

  # Anonymous user
  def visitor_user
    return @visitor_user if defined?(@visitor_user)

    @visitor_user = Visitor::User.find(session[:session_id])
  end

  helper_method :visitor_user

  def logged_in?
    current_user.present?
  end

  helper_method :logged_in?

  def logout

    reset_user_session
    reset_session

    redirect_to login_path
  end

  def reset_user_session
    session[:user_id] = nil
  end

  def redirect_to_with_notice(options = { }, notice = nil)
    redirect_to options, :alert => notice
  end

  # we redirect only first time
  def redirect_to(options = { }, response_status = { }) #:doc:
    unless response_body
      super(options, response_status)
    end
  end

end
