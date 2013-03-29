class DominoController < ApplicationController
  def index
    @user = user
  end

  def welcome
    @user = current_user
  end

  def login
    @user = current_user
  end

  protected

  def user
    @user ||= current_user
  end
end
