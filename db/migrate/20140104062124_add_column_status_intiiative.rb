class AddColumnStatusIntiiative < ActiveRecord::Migration
 def change
  add_column :initiatives, :status, :integer
 end
end