class ChangeDataTypeAntraeges < ActiveRecord::Migration
  def change
    change_column :antraeges, :last_updated, :datetime
  end
end