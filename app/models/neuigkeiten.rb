class Neuigkeiten < ActiveRecord::Base
  attr_accessible :content, :datum, :title, :user_id, :guid, :feed_name, :pubDate,
    :description, :link, :initiative_id, :date, :latitude, :longitude, :openinghours, :postalcode, :street, :city

  belongs_to :user
  belongs_to :initiative

  scope :recent, limit(3).order("created_at desc")
  validates :title, :length => { :maximum => 250, :message => :maximum_title}
  validates :street, :length => { :maximum => 250, :message => :maximum_street}
  validates :city, :length => { :maximum => 250, :message => :maximum_city}

end
