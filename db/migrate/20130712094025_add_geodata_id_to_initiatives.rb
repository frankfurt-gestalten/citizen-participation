class AddGeodataIdToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :geodata_id, :integer
  end
end
