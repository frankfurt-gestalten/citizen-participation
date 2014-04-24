class CreateQuarterSubscriptions < ActiveRecord::Migration
  def change
    create_table :quarter_subscriptions do |t|
      t.integer :quarter_id
      t.references :user

      t.timestamps
    end
  end
end
