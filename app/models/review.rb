class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, class_name: 'User'

  validates :description, presence: true
  validates :rating, presence: true
  validates :reservation_id, presence: true
  validates :reservation, presence: true
  validate :reservation_has_been_accepted
  validate :reservation_checkout_has_passed

  private

  def reservation_has_been_accepted
    unless self.reservation && self.reservation.status == "accepted"
      errors.add(:reservation, "Review cannot be submitted unless the reservation has been accepted.")
    end
  end

  def reservation_checkout_has_passed
    unless self.reservation && self.reservation.checkout < Time.new.to_date
      errors.add(:reservation, "Review cannot be submitted unless the check-out date has passed.")
    end
  end
end
