class ValidReservation < ActiveModel::Validator
  def validate(record)
    unless record.reservation_id && record.reservation.checkout.strftime.remove("-").to_i > Time.now.to_i
      record.errors[:review] << 'rview must be after checkout and valid'
    end
  end
end
