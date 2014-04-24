class ChangeAntraeges < ActiveRecord::Migration
  def change
    rename_column :antraeges, :begruendung, :content
    rename_column :antraeges, :betreff, :federfuehrend
    rename_column :antraeges, :partei, :verfasser

    remove_column :antraeges, :aktualisiert
    remove_column :antraeges, :datum
    remove_column :antraeges, :nummer
    remove_column :antraeges, :ob_nummer
    remove_column :antraeges, :ergebnisse
  end
end
