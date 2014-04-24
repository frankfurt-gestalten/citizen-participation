class AddLastCheckAtToSearchSubscription < ActiveRecord::Migration
  def change
    add_column :search_subscriptions, :last_check_at, :datetime
  end
end
