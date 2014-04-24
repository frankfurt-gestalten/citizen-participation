class AddColumnNeuigkeiten < ActiveRecord::Migration
  def change
    add_column :neuigkeitens, :link, :string
    add_column :neuigkeitens, :guid, :string
    add_column :neuigkeitens, :description, :text
    add_column :neuigkeitens, :pubDate, :string
  end
end
