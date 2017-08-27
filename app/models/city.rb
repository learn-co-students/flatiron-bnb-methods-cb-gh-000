class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def city_openings(from, to)
    openings = []

    self.listings.each do |listing|
      # (StartA <= EndB) and (EndA >= StartB)
      if listing.reservations.none? {|r|  r.checkin <= to.to_date and r.checkout >= from.to_date }
        openings << listing
      end

    end

    openings
  end



  def self.highest_ratio_res_to_listings
    record = {highest_reservations: 0, city_with_highest_r: nil, temp: 0}

    City.all.each do |city|
      record[:temp] = 0

      city.listings.each do |listing|
        record[:temp] = record[:temp] + listing.reservations.count
      end

      if record[:highest_reservations] < record[:temp]
        record[:highest_reservations] = record[:temp]
        record[:city_with_highest_r] = city
      end

    end

    record[:city_with_highest_r]
  end


  def self.most_res
    self.highest_ratio_res_to_listings
  end

end
