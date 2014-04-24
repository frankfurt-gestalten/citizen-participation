class CreateSubscriptions < ActiveRecord::Migration
  create_table :subscriptions do |t|
    t.integer :user_id, null: false
    t.references :subscribable, null: false, polymorphic: true

    t.timestamps
  end
  add_index :subscriptions, [:user_id, :subscribable_id], unique: true
end
