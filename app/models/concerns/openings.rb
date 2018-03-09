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
