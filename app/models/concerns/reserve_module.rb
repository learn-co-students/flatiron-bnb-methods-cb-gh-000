module ReservationModules
  module InstanceMethods
    def duration
      self.checkout - self.checkin
    end
    def total_price
      price = self.listing.price
      price * duration
    end
  end
end

class ValidateGuestReservation < ActiveModel::Validator
  def validate(record)
    if record.guest == record.listing.host
      record.errors[:host] << 'host cannot be customer'
    end
  end
end

class ValidateDates < ActiveModel::Validator
  def validate(record)
    unless record.checkout > record.checkin
      record.errors[:guest] << 'checkout must be > checkin'
    end
  end
end

# class ListingCheckinAvailability < ActiveModel::Validator
#   def validate(record)
#     checkin_dates = []
#     record.listing.reservations.each do |reservation|
#       checkin_dates << reservation.checkin
#     end
#     unless checkin_dates.include?(record.checkin)
#       record.errors[:checkin] << 'checkin not available'
#     end
#   end
# end
