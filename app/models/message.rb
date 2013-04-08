class Message < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :user

  def create_one!(attr)
    self.message = attr[:message]
    self.author_id = attr[:author_id]
    self.save!
  end


end
