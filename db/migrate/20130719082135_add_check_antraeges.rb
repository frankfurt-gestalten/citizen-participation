class AddCheckAntraeges < ActiveRecord::Migration
 def change
    add_column :antraeges, :check, :boolean
  end
end
