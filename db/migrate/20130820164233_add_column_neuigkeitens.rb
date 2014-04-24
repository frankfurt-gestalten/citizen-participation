class AddColumnNeuigkeitens < ActiveRecord::Migration
  def change
    add_column :neuigkeitens, :openinghours, :string
    add_column :neuigkeitens, :street, :string
    add_column :neuigkeitens, :city, :string
    add_column :neuigkeitens, :postalcode, :string
  end
end

