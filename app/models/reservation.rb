class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validate :guest_cannot_be_host
  validates :checkin, presence: true
  validates :checkout, presence: true

  private

  def guest_cannot_be_host
    if self.listing.host == self.guest
      errors.add(:listing, "Cannot create a reservation if guest is the host for a listing.")
    end
  end
end
