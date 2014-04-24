class AddKommuneNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :kommune_name, :string
  end
end
