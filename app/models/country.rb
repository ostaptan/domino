class Country < ActiveRecord::Base
  #uncomment to run migration
  attr_accessible :iso, :name, :printable_name, :iso3, :numcode

  def self.names_array
    all.map {|c| c.printable_name}
  end
end
