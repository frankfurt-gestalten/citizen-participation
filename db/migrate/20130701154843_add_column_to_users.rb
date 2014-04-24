class AddColumnToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :provider
      t.string :avatar
      t.string :kommune
      t.string :ortsteil
      t.string :partei
      t.string :verein
      t.string :polit_amt
      t.string :verwaltung
    end
  end
end