require_relative './concerns/review_modules.rb'

class Review < ActiveRecord::Base

  include ActiveModel::Validations

  belongs_to :reservation
  belongs_to :guest, :class_name => "User"
  validates :rating, presence: true
  validates :description, presence: true
  validates_with ValidReservation

end
