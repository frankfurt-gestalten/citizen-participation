class AddDateToNeuigkeiten < ActiveRecord::Migration
  def change
    add_column :neuigkeitens, :date, :datetime
    add_column :neuigkeitens, :latitude, :string
    add_column :neuigkeitens, :longitude, :string
  end
end
