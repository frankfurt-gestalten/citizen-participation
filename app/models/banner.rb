class Banner < ActiveRecord::Base
  attr_accessible :title, :file
  belongs_to :attachable, :polymorphic => true

  mount_uploader :file, BannerUploader

  validates_presence_of :title, :message => :is_required

  scope :random_banner, order("random()").limit(7)
  scope :recent_banner, limit(8)
end
