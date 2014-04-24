class Construction < ActiveRecord::Base
  include Geodata
  attr_accessible :title, :description_long, :description, :end_date, :start_date, :lat, :long, :source_id, :typ

  has_many :comments, as: :commentable, dependent: :destroy

  scope :recent, limit(3).order("start_date desc")
  scope :with_location, ->{ where("lat != ''") }
  scope :current, ->{ where("start_date <= ? and end_date >= ?", Time.now, Time.now) }

  def self.create_from_xml(item, typ)
    model = where(source_id: item.search('Source-Id').first.content).first

    if model.blank?
      model = new(source_id: item.search('Source-Id').first.content)
    end

    geo = item.css('Verortung Verortungselement Koordinaten').first

    model.update_attributes!(title: item.search('Text').first.content,
      description_long: item.search('MeldungsTextLang').first.try(:content),
      start_date: item.search('ZeitraumVon').first.try(:content), end_date: item.css('ZeitraumBis').first.try(:content),
      lat: geo && geo.search('X-Koordinate').first.content, long: geo && geo.search('Y-Koordinate').first.content, typ: typ)
  end
end
