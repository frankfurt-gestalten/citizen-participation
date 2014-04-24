class AddColumnKommuneAntraeges < ActiveRecord::Migration
 def change
   add_column :antraeges, :kommune, :string
 end
end

