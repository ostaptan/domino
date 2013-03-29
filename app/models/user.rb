class User < ActiveRecord::Base
  # attr_accessible :title, :body

  validate_presence_of :name, :email, :passsword

  has_one :history
  has_many :messages
  has_and_belongs_to_many :games

  def welcome_phrase
    "Welcome #{self.name}!"
  end
end
