class CreateSearchSubscriptions < ActiveRecord::Migration
  def change
    create_table :search_subscriptions do |t|
      t.string :query
      t.string :email

      t.timestamps
    end
  end
end
