class AddColumCartodbIdConstructions < ActiveRecord::Migration
  def up
    add_column :constructions, :geodata_id, :integer
  end

  def down
    remove_column :constructions, :geodata_id, :integer
  end
end
