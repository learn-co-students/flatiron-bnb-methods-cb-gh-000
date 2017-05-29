class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validate :guest_cannot_be_host
  validates :checkin, presence: true
  validates :checkout, presence: true

  before_validation :checkin_date_must_be_available
  before_validation :checkout_date_must_be_available

  private

  def guest_cannot_be_host
    if self.listing.host == self.guest
      errors.add(:listing, "Cannot create a reservation if guest is the host for a listing.")
    end
  end

  def checkin_date_must_be_available
    unless self.checkin && self.listing.available_for_res?(self.checkin)
      errors.add(:checkin, "The check-in date is not available.")
    end
  end

  def checkout_date_must_be_available
    unless self.checkout && self.listing.available_for_res?(self.checkout)
      errors.add(:checkout, "The check-out date is not available.")
    end
  end
end
