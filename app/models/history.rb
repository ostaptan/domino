class History < ActiveRecord::Base

  belongs_to :user
  attr_accessible :user_id

  validates_presence_of :user_id
  validates_uniqueness_of :user_id

  def create_for_user!(id)
    unless id.blank? || !id.integer?
      self.user_id = id
      self.save!
    end
  end

end
