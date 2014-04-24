class AddGeodataFieldsToAntraege < ActiveRecord::Migration
  def change
    add_column :antraeges, :geodata_id, :integer
    add_column :antraeges, :long, :string
    add_column :antraeges, :lat, :string
  end
end
