
require_relative './concerns/citymodule.rb'

class Neighborhood < ActiveRecord::Base

  extend CitiesModules::ClassMethods
  include CitiesModules::InstanceMethods

  belongs_to :city
  has_many :listings

end
