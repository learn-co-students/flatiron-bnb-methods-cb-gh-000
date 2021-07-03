
require_relative './concerns/citymodule.rb'
class City < ActiveRecord::Base

  extend CitiesModules::ClassMethods
  include CitiesModules::InstanceMethods

  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods
end
