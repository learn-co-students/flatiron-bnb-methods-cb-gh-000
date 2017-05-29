class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates :checkin, presence: true
  validates :checkout, presence: true
  validate :guest_cannot_be_host
  validate :checkin_must_be_before_checkout
  validate :checkin_date_must_be_available
  validate :checkout_date_must_be_available

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

  def checkin_must_be_before_checkout
    if self.checkin && self.checkout && self.checkout <= self.checkin
        errors.add(:checkout, "The check-out date must be after the check-in date.")
    end
  end
end
