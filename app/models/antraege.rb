class Antraege < ActiveRecord::Base
  include Geodata
  # include Tire::Model::Search
  # include Tire::Model::Callbacks

  #include PgSearch
  #multisearchable :against => [:title, :content, :begruendung, :ergebnisse]

  attr_accessible :begruendung, :datum, :ergebnisse, :title, :partei, :link, :lat, :long, :aktualisiert, :datum, :content

  has_many :comments, as: :commentable
  has_and_belongs_to_many :categories, join_table: 'categories_antraeges'

  has_many :consultations, class_name: 'AntraegeConsultation'

  scope :search, ->(text) do
    where('title ILIKE ? or content ILIKE ?', "%#{text}%", "%#{text}%")
  end

  scope :recent, limit(3).order("last_updated desc")
  scope :with_location, ->{ where("lat != ''") }
  scope :created_after, ->(timestamp) { where('created_at > ?', timestamp) }
  scope :updated_after, ->(timestamp) { where('created_at <= ?', timestamp).where('updated_at > ?', timestamp) }

end