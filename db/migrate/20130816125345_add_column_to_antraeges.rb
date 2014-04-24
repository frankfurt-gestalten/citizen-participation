class AddColumnToAntraeges < ActiveRecord::Migration
  def change
    add_column :antraeges, :docid, :integer
  end
end