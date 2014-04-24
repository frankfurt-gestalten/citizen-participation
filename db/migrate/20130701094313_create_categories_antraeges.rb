class CreateCategoriesAntraeges < ActiveRecord::Migration
  def change
    create_table 'categories_antraeges', id: false do |t|
      t.references :category
      t.references :antraege
    end
  end
end
