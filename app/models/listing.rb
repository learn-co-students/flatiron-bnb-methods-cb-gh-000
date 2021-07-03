require_relative './concerns/listing_module.rb'

class Listing < ActiveRecord::Base

  before_create :change_host_status
  after_destroy :change_host_status_after_destroy_all

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
  include ListingModule::InstanceMethods

  private

  def change_host_status
    self.host.host = "true"
    self.host.save
  end

  def change_host_status_after_destroy_all
    if self.host.listings.empty?
      self.host.host = "false"
      self.host.save
    end
  end

end
