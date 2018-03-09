module CitiesModules
  module InstanceMethods

    def city_openings(start_date, end_date)
      start_numbered_date = start_date.remove("-").to_i
      end_numbered_date = end_date.remove("-").to_i
      listings = []
      excluded_listings = []
      Reservation.all.each { |reservation|
        checkin_numbered_date = reservation.checkin.to_s.remove("-").to_i
        checkout_numbered_date = reservation.checkin.to_s.remove("-").to_i
        if  (checkin_numbered_date..checkout_numbered_date).any? { |n| n.between?(start_numbered_date, end_numbered_date)}
          excluded_listings << reservation.listing
        elsif checkin_numbered_date > end_numbered_date
          listings << reservation.listing
        end
      }
      # City.first.city_openings('2019-05-01', '2010-05-05')
      Listing.all - listings
    end

    def neighborhood_openings(start_date, end_date)
      start_numbered_date = start_date.remove("-").to_i
      end_numbered_date = end_date.remove("-").to_i
      listings = []
      excluded_listings = []
      Reservation.all.each { |reservation|
        checkin_numbered_date = reservation.checkin.to_s.remove("-").to_i
        checkout_numbered_date = reservation.checkin.to_s.remove("-").to_i
        if  (checkin_numbered_date..checkout_numbered_date).any? { |n| n.between?(start_numbered_date, end_numbered_date)}
          excluded_listings << reservation.listing
        elsif checkin_numbered_date > end_numbered_date
          listings << reservation.listing
        end
      }
      # City.first.city_openings('2019-05-01', '2010-05-05')
      Listing.all - listings
    end

  end
  module ClassMethods
    def highest_ratio_res_to_listings
      y = []
      self.all.each { |city|
        x=0
        city.listings.each { |listing|
          x += listing.reservations.count
        }
        y << x
      }
      max = y.max
      i = y.index(max)
      max_city = self.all[i]
    end
    def most_res
      y = []
      self.all.each { |city|
        x=0
        city.listings.each { |listing|
          x += listing.reservations.count
        }
        y << x
      }
      max = y.max
      i = y.index(max)
      max_city = self.all[i]
    end
  end
end
