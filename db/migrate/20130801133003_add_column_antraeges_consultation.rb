class AddColumnAntraegesConsultation < ActiveRecord::Migration
  def change
    add_column :antraeges, :antraege_id, :integer
  end
end
