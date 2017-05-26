class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def city_openings(start_date, end_date)
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
    reservation_count / listings.count
  end

  def reservation_count
    res_count = 0

    listings.each do |listing|
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

  def self.most_res
    res_counts = self.all.map { |city| city.reservation_count }
    highest_res_count = res_counts.max
    self.all.find do |city|
      city.reservation_count == highest_res_count
    end
  end

  private

  def periods_overlap?(period_one_start, period_one_end, period_two_start, period_two_end)
    period_one_start <= period_two_end && period_one_end >= period_two_start
  end
end

