class Constructions < ActiveRecord::Migration
  def change
    create_table :constructions do |t|
      t.text :description
      t.text :subtitle
      t.datetime :start_date
      t.datetime :end_date
      t.string :_id
      t.string :lat
      t.string :lng
      t.string :organisation
      t.text :name
      t.text :approx_timeframe
      t.boolean :exact_position
      t.string :city
      t.boolean :sidewalk_only

      t.timestamps
    end
  end
end
