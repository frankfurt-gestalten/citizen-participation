class AddPublicFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :public_fields, :string
  end
end
