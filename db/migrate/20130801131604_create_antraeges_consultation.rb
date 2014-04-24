class CreateAntraegesConsultation < ActiveRecord::Migration
  def change
    create_table :antraeges_consultation do |t|
      t.string :status
      t.string :action
      t.string :committee
      t.string :toplfdnr
      t.text :meeting
      t.integer :silfdnr
      t.timestamps
    end
  end
end
