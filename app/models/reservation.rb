
require_relative './concerns/reserve_module.rb'

class Reservation < ActiveRecord::Base

  include ActiveModel::Validations
  include ReservationModules::InstanceMethods

  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates :checkin, presence: true
  validates :checkout, presence: true
  validates_with ValidateGuestReservation
  validates_with ValidateDates

end
