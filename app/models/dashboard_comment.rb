class DashboardComment < ActiveRecord::Base
  serialize :likers, Array
  serialize :dislikers, Array

  attr_accessible :content, :user_id, :post_id

  belongs_to :dashboard_news
  belongs_to :author, :class_name => User

  include DashboardExt::Likes

  def get_author
    User.find_by_id self.user_id
  end

end
