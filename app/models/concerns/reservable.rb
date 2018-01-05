module Reservable
   extend ActiveSupport::Concern

  def openings(start_date, end_date)
    listings.merge(Listing.available(start_date, end_date))
  end

  def ratio_reservations_to_listings
    if listings.count > 0
      reservations.count.to_f / listings.count.to_f
    end
  end

  class_methods do
    def highest_ratio_res_to_listings
      self.all.max_by do |location|
        if location.listings.count > 0 && location.reservations.count > 0
          location.reservations.count.to_f/location.listings.count.to_f
        else
          0
        end
      end
    end

    def most_res
      self.all.max do |a, b|
        a.reservations.count <=> b.reservations.count
      end
    end
  end
end