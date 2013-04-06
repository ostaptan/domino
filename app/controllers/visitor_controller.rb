class VisitorController < ApplicationController

  include VisitorExtensions::Register

  def welcome
  end

  def about

  end

  def login
    redirect_to domino_index_path if logged_in?
    @user = User.new
  end

  def do_login

    email = params[:email]
    pswd = params[:password]

    unless email.blank? || pswd.blank?
      user = User.find_by_email(email).try(:authenticate, email, pswd)
      if user
        url = domino_index_path
        #send_mail(user)
        return if login_user(user, url)
      end
    end
    redirect_to_with_notice login_path, t(:invalid_login_or_password), :error
  end

  private

  def login_user(user, redirect_url = nil)
    redirect_url ||= { :controller => 'domino' }

    return false unless user.first.active?

    raise "Admin can't be active" if user.first.is_admin?

    session[:user_id] = user.first.id

    redirect_to redirect_url
    true
  end

  def send_mail(user)
    m = TMail::Mail.new

    m.subject = "Welcome to Gold Dust"
    m.to, m.from = user.mail, 'gold dust'
    m.date = Time.now
    m.body = "Thank you for registering in Gold Dust. Your username is #{user.name} and
              your password is not available to see even for us))"

    ActionMailer::Base.deliver(m)
  end
end
