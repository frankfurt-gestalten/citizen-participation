class RenameColumnConstrucions < ActiveRecord::Migration
  def change
    rename_column :constructions, :description, :title
  end
end
