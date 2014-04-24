class RenameColumnLngConstructions < ActiveRecord::Migration
  def change
    rename_column :constructions, :lng, :long
  end
end
