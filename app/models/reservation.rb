
require_relative './concerns/reserve_module.rb'

class Reservation < ActiveRecord::Base

  include ActiveModel::Validations
  include ReservationModules::InstanceMethods

  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates :checkin, :checkout, presence: true
  validates_with ValidateGuestReservation
  validates_with ValidateDates
  validate :available
  
  private

  def available
    Reservation.where(listing_id: listing.id).where.not(id: id).each do |r|
      booked_dates = r.check_in..r.check_out
      if booked_dates === check_in || booked_dates === check_out
        errors.add(:guest_id, "Sorry, this place isn't available during your requested dates.")
      end
    end
  end
  
end
