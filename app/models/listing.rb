class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  before_create :set_host
  after_destroy :update_host_status

  validates :address, presence: true
  validates :listing_type, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :neighborhood_id, presence: true

  private

  def set_host
    self.host.update(host: true)
  end

  def update_host_status
    self.host.update(host: false) if self.host.listings.count.zero?
  end
end
