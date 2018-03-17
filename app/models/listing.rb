class Listing < ActiveRecord::Base
  belongs_to :neighborhood, required: true
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  validates :address, presence: true
  validates :description, presence: true
  validates :listing_type, presence: true
  validates :price, presence: true
  validates :title, presence: true

  after_save :set_host
  after_destroy :unset_host

  def average_review_rating
    reviews.average(:rating)
  end



  private

  def set_host
    self.host.update(host: true)
  end
  def unset_host
    if self.host.listings.empty?
      self.host.update(host: false)
    end
  end
end





