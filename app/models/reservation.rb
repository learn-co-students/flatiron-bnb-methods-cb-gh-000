class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review
  validates :checkin, presence: true
  validates :checkout, presence: true
  validate :cannot_reserve_own_listing
  validate :cannot_have_invalid_dates
  validate :checkin_before_checkout

  def cannot_reserve_own_listing
    if self.guest_id == self.listing.host.id
      errors.add(:same_guest_user, 'User cannot reserve their own listing')
    end
  end

  def cannot_have_invalid_dates
    if !!self.checkin && !!self.checkout
      if self.listing.reservations.any? {|r|  r.checkin <= self.checkout and r.checkout >= self.checkin }
        errors.add(:conflict, 'Invalid dates, conflicts!')
      end
    end
  end


  def checkin_before_checkout
    if !!self.checkin && !!self.checkout
      if self.checkin >= self.checkout
        errors.add(:bad_error, 'Checkout before Checkin?')
      end
    end
  end


  def duration
    (self.checkout - self.checkin).to_i
  end

  def total_price
    self.listing.price * (self.duration).to_f
  end

end
