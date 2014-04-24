class AddColumnLastUpdatedAntraeges < ActiveRecord::Migration
  def change
    add_column :antraeges, :last_updated, :date
  end
end

