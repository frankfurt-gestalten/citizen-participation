class AddUserNameAndEmailToComments < ActiveRecord::Migration
  def change
    add_column :comments, :user_name, :string
    add_column :comments, :user_email, :string
  end
end
