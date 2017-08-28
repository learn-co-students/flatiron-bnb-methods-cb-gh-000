class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations
  validates :address, presence: true
  validates :listing_type, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :neighborhood, presence: true
  after_create :convert_user_to_host
  after_destroy :convert_host_to_user

  def convert_user_to_host
    self.host.update(host: true)
  end

  def convert_host_to_user
    if self.host.listings.empty?
      self.host.update(host: false)
    end
  end

  def average_review_rating
    self.reviews.average(:rating)
  end

end
