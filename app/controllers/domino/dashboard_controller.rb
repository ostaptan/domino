class Domino::DashboardController < DominoController

  include Domino::Dashboard::NewsController

  before_filter :find_post, only: [:like_post, :dislike_post, :like_comment, :dislike_comment]

  def index
    @post = DashboardNews.new
    @comment = DashboardComment.new
    @posts = DashboardNews.order('created_at desc').paginate(page: params[:page], per_page: 5).includes(:comments, :author)
  end

  def show_more
    @post = DashboardNews.find_by_id params[:id]
    @comment = DashboardComment.new
  end

end