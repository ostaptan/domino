class FacebookController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    cookies[:remember_me_token] = user.remember_me_token
    redirect_to root_url
  end
end