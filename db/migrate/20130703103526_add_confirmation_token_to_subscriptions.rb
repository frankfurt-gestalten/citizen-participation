class AddConfirmationTokenToSubscriptions < ActiveRecord::Migration
  def change
    add_column :search_subscriptions, :confirmation_token, :string
  end
end
