class AddColumnUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :nutzungsbedingung
    end
  end
end