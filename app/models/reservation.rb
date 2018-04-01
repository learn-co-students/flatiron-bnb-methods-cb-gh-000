class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  
  has_one :review

  validates :checkin, presence: true
  validates :checkout, presence: true

  validate :check_out_after_check_in, :book_your_own, :available

  def duration
    (checkout - checkin).to_i
  end

  def total_price
    listing.price * duration
  end

  def check_out_after_check_in
    if self.checkin && self.checkout && self.checkout <= self.checkin
      errors.add(:guest_id, 'heck_out_after_check_in')
    end
  end
  def book_your_own
    if guest_id == listing.host_id
      errors.add(:guest_id, "You can't book your own apartment.")
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
