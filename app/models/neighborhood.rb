class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings
  def neighborhood_openings(from, to)
    openings = []

    self.listings.each do |listing|
      if listing.reservations.none? {|r|  r.checkin <= to.to_date and r.checkout >= from.to_date }
        openings << listing
      end

    end

    openings
  end

  def self.highest_ratio_res_to_listings
    record = {highest_reservations: 0, neighbor_with_highest_r: nil, temp: 0}

    Neighborhood.all.each do |neighbor|
      record[:temp] = 0

      neighbor.listings.each do |listing|
        record[:temp] = record[:temp] + listing.reservations.count
      end

      if record[:highest_reservations] < record[:temp]
        record[:highest_reservations] = record[:temp]
        record[:neighbor_with_highest_r] = neighbor
      end

    end

    record[:neighbor_with_highest_r]
  end


  def self.most_res
    self.highest_ratio_res_to_listings
  end
end
