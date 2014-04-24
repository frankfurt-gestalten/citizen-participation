class Initiative < ActiveRecord::Base
  include Geodata
  #include PgSearch
  #multisearchable :against => [:title, :content]

  attr_accessible :content, :erreicht, :getan, :lat, :long, :title, :remove_file, :file, :fotos_attributes, :user_id, :category_ids, :visible, :updated_at

  belongs_to :user
  has_many :fotos, :as => :attachable
  has_many :neuigkeitens
  has_many :subscriptions, :as => :subscribable, dependent: :destroy
  has_many :supporters, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_and_belongs_to_many :categories, join_table: 'categories_initiatives'
  accepts_nested_attributes_for :fotos, :allow_destroy => true, :reject_if => lambda { |a| a[:title].blank? && a[:file].blank? }

  validates_presence_of :content, :user_id, :title, :message => :is_required

  before_save :update_quarter_id

  scope :recent, limit(5).order("created_at desc").where('visible = true')
  scope :active, limit(5).order("updated_at desc").where('visible = true')
  scope :with_location, ->{ where("lat != ''") }
  scope :created_after, ->(timestamp) { where('created_at > ?', timestamp) }
  scope :updated_after, ->(timestamp) { where('created_at <= ?', timestamp).where('updated_at > ?', timestamp) }

  scope :search, ->(text) do
    where('title ILIKE ? or content ILIKE ?', "%#{text}%", "%#{text}%")
  end

  def subscribe(user)
    unless subscriptions.exists?(user_id: user.id)
      subscriptions.create!(user: user)
    end
  end

  def unsubscribe(user)
    if subscription = subscriptions.find_by_user_id(user.id)
      subscription.destroy
    end
  end

  def update_quarter_id
    if (lat_changed? || long_changed?) && lat.present? && long.present?
      self.quarter_id = Quarter.id_for_coordinates(long, lat)
    end
  end

  def last_activity_at
    if last_comment_at && updated_at
      last_comment_at > updated_at ? last_comment_at : updated_at
    else
      updated_at
    end
  end
end
