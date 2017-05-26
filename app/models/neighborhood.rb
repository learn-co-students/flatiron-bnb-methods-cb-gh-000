class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings

  def neighborhood_openings(start_date, end_date)
    listings.collect do |listing|
      overlapping_reservations = listing.reservations.collect do |reservation|
        reservation if periods_overlap?(reservation.checkin.to_s,
                                        reservation.checkout.to_s,
                                        start_date,
                                        end_date)
      end
      listing if overlapping_reservations.compact.empty?
    end
  end

  def ratio_res_to_listings
    if self.listings.count.zero?
      0
    else
      reservation_count / self.listings.count
    end
  end

  def reservation_count
    res_count = 0

    self.listings.each do |listing|
      res_count += listing.reservations.count
    end

    res_count
  end

  def self.highest_ratio_res_to_listings
    res_to_listings_ratios = self.all.map { |city| city.ratio_res_to_listings }
    highest_ratio_res_to_listings = res_to_listings_ratios.max
    self.all.find do |city|
      city.ratio_res_to_listings == highest_ratio_res_to_listings
    end
  end

  private

  def periods_overlap?(period_one_start, period_one_end, period_two_start, period_two_end)
    period_one_start <= period_two_end && period_one_end >= period_two_start
  end
end
