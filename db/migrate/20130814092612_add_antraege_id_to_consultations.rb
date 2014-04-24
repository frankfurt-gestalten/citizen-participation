class AddAntraegeIdToConsultations < ActiveRecord::Migration
  def change
    remove_column :antraeges, :antraege_id
    add_column :antraeges_consultation, :antraege_id, :integer
    add_index :antraeges_consultation, :antraege_id
  end
end
