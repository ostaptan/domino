class VisitorController < ApplicationController

  include VisitorExtensions::Register

  def welcome
    redirect_to domino_index_path if logged_in?
    @user = User.new
  end

  def about
  end

  def login
  end

  def set_localization
    locale = params[:locale] || I18n.default_locale
    #second for translating env without logging in
    current_user ? current_user.set_locale(locale) : I18n.locale = locale
    redirect_to_with_notice root_path, t('notices.localization_changed', locale: locale)
  end

  def do_login

    email = params[:email]
    pswd = params[:password]

    unless email.blank? || pswd.blank?
      users_array = User.find_by_email(email).try(:authenticate, email, pswd)
      if users_array && !users_array.blank?
        url = domino_index_path
        #send_mail(user)
        return if login_user(users_array.first, url)
      end
    end
    redirect_to_with_notice root_path, t(:invalid_login_or_password), :error
  end

  private

  def login_user(user, redirect_url = nil)
    redirect_url ||= { :controller => 'domino' }

    return false unless user.active?

    raise "Admin can't be active" if user.is_admin?

    session[:user_id] = user.id

    redirect_to redirect_url
    true
  end

  def send_mail(user)
    m = TMail::Mail.new

    m.subject = "Welcome to Domino"
    m.to, m.from = user.mail, 'domino'
    m.date = Time.now
    m.body = "Thank you for registering in Domino. Your username is #{user.name} and
              your password is not available to see even for us))"

    ActionMailer::Base.deliver(m)
  end
end
