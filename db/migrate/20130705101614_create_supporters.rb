class CreateSupporters < ActiveRecord::Migration
  create_table :supporters do |t|
    t.integer :user_id, null: false
    t.integer :initiative_id, null: false

    t.timestamps
  end
  add_index :supporters, [:user_id, :initiative_id], unique: true
end
