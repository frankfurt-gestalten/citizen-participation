class CreateNeuigkeitens < ActiveRecord::Migration
  def change
    create_table :neuigkeitens do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.datetime :datum

      t.timestamps
    end
  end
end
