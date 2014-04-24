class Page < ActiveRecord::Base

  attr_accessible :title, :content

  validates_presence_of :title, :content, :slug
  validates_uniqueness_of :slug

  scope :search, ->(text) do
    term = "%#{text}%"
    where('((title ILIKE ?) OR (content ILIKE ?))', term, term)
  end

  def self.find_by_slug!(slug)
    where(slug: slug).first!
  end

  def title=(title)
    self.slug = title.to_url
    super(title)
  end
end
