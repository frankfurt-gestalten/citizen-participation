class AddColumnInitiative < ActiveRecord::Migration
  def change
     add_column :initiatives, :kommune_feld, :string
  end
end
