class VisitorController < ApplicationController

  include VisitorExtensions::Register

  def welcome
    redirect_to dd_index_path if logged_in?
    @user = User.new
  end

  def about
  end

  def login
  end

  def activate
    @user = User.find_by_remember_me_token! params[:token] if params[:token]
    if @user
      @user.activate_account!
      @activated = true
    end
  end

  def set_localization
    callback_url = params[:url] || root_path
    locale = params[:locale] || I18n.default_locale
    #second for translating env without logging in
    current_user ? current_user.set_locale(locale) : I18n.locale = locale
    redirect_to_with_notice callback_url, t('notices.localization_changed', count: locale)
  end

  def do_login

    email = params[:email]
    pswd = params[:password]

    unless email.blank? || pswd.blank?
      users_array = User.find_by_email(email).try(:authenticate, email, pswd)
      if users_array && !users_array.blank?
        url = domino_index_path
        #send_mail(user)
        return if login_user(users_array.first, domino_index_path)
      end
    end
    redirect_to_with_notice root_path, t(:invalid_login_or_password), :error
  end

  protected

  def register_user
    @user = User.new
  end

  private

  def login_user(user, redirect_url = nil)
    redirect_url ||= { :controller => 'dd' }

    return false unless user.active?

    raise "Admin can't be active" if user.is_admin?

    if params[:remember_me]
      cookies.permanent[:remember_me_token] = user.remember_me_token
    else
      cookies[:remember_me_token] = user.remember_me_token
    end

    redirect_to redirect_url
    true
  end

end
