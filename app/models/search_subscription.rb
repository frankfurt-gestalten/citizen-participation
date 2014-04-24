class SearchSubscription < ActiveRecord::Base
  attr_accessible :email, :query

  scope :confirmed, ->{ where(confirmation_token: nil) }

  #checkx validate that search term is not too long (only varchar field)
  def self.build_for(params, user)
    SearchSubscription.new(params).tap do |subscription|
      subscription.email = user.email if user
      subscription.generate_confirmation_token! unless user
      subscription.last_check_at = Time.now
    end
  end

  def self.notify
    confirmed.each do |subscription|
      subscription.notify
    end
  end

  def notify
    model_classes = [Antraege, Initiative]

    search_results = Antraege.search(query).to_a + Initiative.search(query).to_a

    models = model_classes.inject({}) do |hash, model_class|
      new_ids = model_class.created_after(last_check_at).pluck(:id)
      updated_ids = model_class.updated_after(last_check_at).pluck(:id)

      hash[model_class] =
        {
          new: search_results.select { |s| s.is_a?(model_class) && new_ids.include?(s.id) },
          updated: search_results.select { |s| s.is_a?(model_class) && updated_ids.include?(s.id) }
        }
      hash
    end

    if models.values.any? { |updates| updates.values.any?(&:present?) }
      SubscriptionMailer.notify(self, models).deliver
    end

    update_column(:last_check_at, Time.now)
  end

  def generate_confirmation_token!
    self.confirmation_token = SecureRandom.urlsafe_base64(32)
  end

  def confirm!
    update_column(:confirmation_token, nil)
  end
end
