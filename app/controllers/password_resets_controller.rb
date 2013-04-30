class PasswordResetsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to_with_notice root_url, t('reset_password.email_sent_reset')
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    unless @user.from_facebook?
      if params[:confirm_password] == params[:password]
        params[:user].delete :confirm_password
        if @user.password_reset_sent_at < 2.hours.ago
          redirect_to new_password_reset_path, :alert => t('reset_password.pass_expired')
        elsif @user.reset_password!(params[:user])
          redirect_to_with_notice root_url, t('reset_password.pass_reset')
        else
          render :edit
        end
      else
        redirect_to new_password_reset_path, :alert => t('reset_password.confirmation_not_match')
      end
    end
  end
end
