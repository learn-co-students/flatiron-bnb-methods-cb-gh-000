class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def city_openings(start_date, end_date)
    open_listings = self.listings.collect do |listing|
      overlapping_reservations = listing.reservations.collect do |reservation|
        reservation if periods_overlap?(reservation.checkin.to_s,
                                        reservation.checkout.to_s,
                                        start_date,
                                        end_date)
      end
      listing if overlapping_reservations.compact.empty?
    end

    open_listings.compact
  end

  private

  def periods_overlap?(period_one_start, period_one_end, period_two_start, period_two_end)
    if period_one_start <= period_two_end && period_one_end >= period_two_start
      true
    else
      false
    end
  end
end

