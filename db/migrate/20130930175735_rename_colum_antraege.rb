class RenameColumAntraege < ActiveRecord::Migration
  def change
    rename_column :antraeges, :betreff, :content
  end
end
