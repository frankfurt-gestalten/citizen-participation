class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :commentable_id
      t.string :commentable_type
      t.integer  :user_id
      t.string   :ancestry

      t.timestamps
    end
    add_index :comments, [:ancestry], :name => "index_comments_on_ancestry"
    add_index :comments, [:commentable_id, :commentable_type], :name => "index_comments_on_commentable_id_and_commentable_type"
  end
end
