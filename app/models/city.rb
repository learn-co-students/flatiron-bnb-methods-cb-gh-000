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

  end


end

