class DashboardNews < ActiveRecord::Base
  serialize :likers, Array
  serialize :dislikers, Array

  attr_accessible :header, :content, :author

  belongs_to :author, class_name: User, foreign_key: :user_id
  has_many :comments, class_name: DashboardComment, foreign_key: :post_id

  scope :active, {:conditions => ['active = ?', true]}

  validates_presence_of :header, :content

  include DashboardExt::Likes

end
