class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :type
      t.string :name
      t.string :content

      t.timestamps
    end
  end
end