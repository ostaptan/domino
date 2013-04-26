class Domino::DashboardController < DominoController

  include Domino::Dashboard::NewsController

  before_filter :find_post, only: [:like_post, :dislike_post]

  def index
    @post = DashboardNews.new
    @posts = DashboardNews.active.order('created_at desc')
  end

end