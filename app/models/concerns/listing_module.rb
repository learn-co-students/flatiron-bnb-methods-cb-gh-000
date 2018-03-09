
module ListingModule

  module InstanceMethods
    def average_review_rating
      listing_reviews_calculation = 0
      self.reviews.each { |review|
        listing_reviews_calculation += review.rating.to_i
      }
      reviews_count = self.reviews.count
      listing_average_rating = (listing_reviews_calculation* 10 / reviews_count)*0.1
    end
  end

end
