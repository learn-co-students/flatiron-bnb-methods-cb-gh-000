class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"
  validates :description, presence: true
  validates :rating, presence: true
  validates :reservation, presence: true
  validate :reservation_happened

  def reservation_happened
    if !!reservation
      if self.reservation.checkout > Time.now
        errors.add(:reservation_happened, 'Must have checkout before adding a review')
      end
    end
  end

end
