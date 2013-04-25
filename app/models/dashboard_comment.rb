class DashboardComment < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :dashboard_news
  belongs_to :author, :class_name => User

  def self.create_one!(attr)

  end

end
