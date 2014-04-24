class ChangeTableConstructions < ActiveRecord::Migration
  def change
    rename_column :constructions, :_id, :source_id
    rename_column :constructions, :subtitle, :title
    rename_column :constructions, :organisation, :description_long
    remove_column :constructions, :approx_timeframe
    remove_column :constructions, :sidewalk_only
    remove_column :constructions, :city
    remove_column :constructions, :exact_position
    remove_column :constructions, :name
  end
end
