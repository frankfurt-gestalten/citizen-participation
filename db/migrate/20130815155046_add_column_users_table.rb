class AddColumnUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :jahrgang, :string
    add_column :users, :notes, :text
  end
end