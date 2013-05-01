class Clan < ActiveRecord::Base
  # attr_accessible :title, :body

  include Rules::ClanRules
  include Tire::Model::Search
  include Tire::Model::Callbacks

  has_many :users

  TYPES = [GameProperties::SMALL, GameProperties::MEDIUM, GameProperties::BIG, GameProperties::HUGE]

  def self.create_one!(attr)

  end

end
