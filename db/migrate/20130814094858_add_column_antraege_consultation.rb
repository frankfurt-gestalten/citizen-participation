class AddColumnAntraegeConsultation < ActiveRecord::Migration
 def change
    add_column :antraeges_consultation, :update, :date
    add_column :antraeges_consultation, :decision, :text
  end
end