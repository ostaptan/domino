class Domino::DashboardController < DominoController

  include Domino::Dashboard::NewsController

  before_filter :find_post, only: [:like_post, :dislike_post, :like_comment, :dislike_comment]

  def index
    #news extensions
    @post = DashboardNews.new
    @comment = DashboardComment.new
    @posts = DashboardNews.order('created_at desc').paginate(page: params[:page], per_page: 5).includes(:comments, :author)

    #events extensions
    @events = PublicActivity::Activity.order("created_at desc").includes(:owner, :trackable).where(owner_id: current_user.friendships.map {|f| f.friend_id}, owner_type: "User")

    # forum extensions
    @user = current_user
    @messages = Message.includes(:user).all
    @message = Message.new
  end

  # shows more comments
  def show_more
    @post = DashboardNews.find_by_id params[:id]
    @comment = DashboardComment.new
  end

  #destroyes news post
  def destroy
    @post = DashboardNews.find_by_id params[:id]
    if @post && current_user.can_delete_post?(@post)
      @post.create_activity :delete, owner: current_user
      @post.delete_me!
      redirect_to_with_notice domino_dashboard_index_path, t('notices.post_deleted')
    else
      redirect_to_with_notice domino_dashboard_index_path, t('notices.cannot_post_delete')
    end
  end

  # creates message on forum
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