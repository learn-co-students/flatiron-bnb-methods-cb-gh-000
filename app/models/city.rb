class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def city_openings(start_date, end_date)
    listings = self.listings

    open_listings = listings.collect do |listing|
      reservations = listing.reservations

      overlapping_reservations = reservations.collect do |reservation|
        reservation_checkin = reservation.checkin.to_s
        reservation_checkout = reservation.checkout.to_s

        if reservation_checkin <= end_date && reservation_checkout >= start_date
          reservation_overlaps_user_dates = true
        else
          reservation_overlaps_user_dates = false
        end

        reservation if reservation_overlaps_user_dates
      end

      listing if overlapping_reservations.compact.empty?
    end

    open_listings.compact
  end
end

