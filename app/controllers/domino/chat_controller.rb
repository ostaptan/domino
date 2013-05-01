class Domino::ChatController < DominoController

  def index
    @user = current_user
    @messages = Message.includes(:user).all
    @message = Message.new
  end

  def create
    @message = Message.new
    @message.create_one!(params[:message])
    #Juggernaut.publish(1, parse_chat_message(params[:message][:message], current_user))
    respond_to do |format|
      format.html { redirect_to :index }
      format.js
    end
  end
end
