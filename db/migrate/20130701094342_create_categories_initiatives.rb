class CreateCategoriesInitiatives < ActiveRecord::Migration
  def change
      create_table 'categories_initiatives', id: false do |t|
        t.references :category
        t.references :initiative
      end
  end
end
