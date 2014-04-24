class AddColumQuestions < ActiveRecord::Migration
  def change
   add_column :questions, :description, :text
  end
end