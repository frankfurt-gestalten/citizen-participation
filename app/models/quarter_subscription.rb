class QuarterSubscription < ActiveRecord::Base
  attr_accessible :quarter_id

  belongs_to :user

  def email
    user.email
  end
end
