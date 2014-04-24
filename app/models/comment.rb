class Comment < ActiveRecord::Base
  attr_accessible :content, :user_name, :user_email
  belongs_to :commentable, polymorphic: true, touch: :last_comment_at
  belongs_to :user
  has_ancestry

  scope :created_after, ->(timestamp) { where('created_at > ?', timestamp) }

  validates_presence_of :user_id, unless: :user_name
  validates_presence_of :user_name, unless: :user_id
  #validates_presence_of :user_email, unless: :user_id

  validates_length_of :content, :message => :is_too_short, :minimum => 3

  scope :for_items, ->(initiative_ids, antraege_ids) do
    where("((comments.commentable_id IN (?) AND comments.commentable_type='Initiative') OR " +
      "(comments.commentable_id IN (?) AND comments.commentable_type='Antraege'))",
      initiative_ids, antraege_ids).limit(5)
  end

  scope :recent, limit(5).order("created_at desc")
end
