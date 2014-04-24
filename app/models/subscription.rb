class Subscription < ActiveRecord::Base
  attr_accessible :subscribable_id, :subscribable_type, :subscribable, :user

  belongs_to :subscribable, polymorphic: true
  belongs_to :user
end