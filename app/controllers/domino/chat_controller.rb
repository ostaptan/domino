class Domino::ChatController < ApplicationController

  def index
    @user = current_user
    @messages = Message.all
  end

  def new
    @message = Message.new
  end

  def create
    @message.create_one!(params[:message])
  end
end
