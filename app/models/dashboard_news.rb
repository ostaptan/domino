class DashboardNews < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :author, :class_name => User

  def self.create_one!(attr)

  end

end
