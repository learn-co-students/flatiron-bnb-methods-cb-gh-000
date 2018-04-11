class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates :checkin, presence: true
  validates :checkout, presence: true

  validate :host_and_guest_not_same
  validate :checkout_after_checkin
  validate :available

  def duration
    (checkout -  checkin).to_i
  end

  def total_price
    listing.price * duration
  end

  def host_and_guest_not_same
    if guest_id == listing.host_id
      errors.add(:guest_id, "You can't book your own apartment.")
    end
  end

  def checkout_after_checkin
    if checkout && checkin && checkout <= checkin
      errors.add(:guest_id, "Checkout must be after checkin")
    end
  end

  def available
  Reservation.where(listing_id: listing.id).where.not(id: id).each do |r|
    booked_dates = r.checkin..r.checkout
    if booked_dates === checkin || booked_dates === checkout
      errors.add(:guest_id, "Sorry, this place isn't available during your requested dates.")
    end
  end
end
end
