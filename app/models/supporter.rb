class Supporter < ActiveRecord::Base

  attr_accessible :initiative_id, :user

  belongs_to :initiative
  belongs_to :user
end