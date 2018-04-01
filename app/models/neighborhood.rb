class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings
  has_many :reservations, through: :listings

  include Reserve

  def neighborhood_openings(from, to)
    openings(from, to)
  end
end
