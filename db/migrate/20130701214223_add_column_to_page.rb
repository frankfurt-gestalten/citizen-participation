class AddColumnToPage < ActiveRecord::Migration
  def change
    change_table :pages do |t|
      t.string :slug
    end
  end
end