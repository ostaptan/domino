class Game < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :players, :class_name => User




end
