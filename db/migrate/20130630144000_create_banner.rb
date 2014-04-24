class CreateBanner < ActiveRecord::Migration
 def change
    create_table :banners do |t|
      t.string :title
      t.integer  :user_id
      t.string :file

      t.timestamps
    end
  end
end
