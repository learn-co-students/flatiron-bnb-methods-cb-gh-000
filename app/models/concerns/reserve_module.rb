
class ValidateGuestReservation < ActiveModel::Validator
  def validate(record)
    if record.guest == record.listing.host
      record.errors[:host] << 'Need a name starting with X please!'
    end
  end
end

class ListingCheckinAvailability < ActiveModel::Validator
  def validate(record)
    checkin_dates = []
    record.listing.reservations.each do |reservation|
      checkin_dates << reservation.checkin
    end
    unless checkin_dates.include?(record.checkin)
      record.errors[:checkin] << 'checkin not available'
    end
  end
end

