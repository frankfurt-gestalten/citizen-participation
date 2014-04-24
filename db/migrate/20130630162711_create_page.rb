class CreatePage < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :title
      t.text :content

      t.timestamps
    end
  end
end
