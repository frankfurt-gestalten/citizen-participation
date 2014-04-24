class CreateAntraeges < ActiveRecord::Migration
  def change
    create_table :antraeges do |t|
      t.date :aktualisiert
      t.string :link
      t.date :datum
      t.string :partei
      t.string :nummer
      t.text :title
      t.text :begruendung
      t.text :betreff
      t.text :ergebnisse
      t.integer :ob_nummer

      t.timestamps
    end
  end
end
