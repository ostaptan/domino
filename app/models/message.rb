class Message < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :user, :foreign_key => :author_id

  def create_one!(attr)
    self.message = attr[:message]
    self.author_id = attr[:author_id]
    self.save!
  end

  def author
    user
  end


end
