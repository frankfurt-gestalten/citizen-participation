class CreateInitiatives < ActiveRecord::Migration
  def change
    create_table :initiatives do |t|
      t.text :title
      t.text :content
      t.text :erreicht
      t.text :getan
      t.integer :user_id
      t.text :lat
      t.text :long

      t.timestamps
    end
  end
end
