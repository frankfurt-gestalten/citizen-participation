class AddLastCommentAt < ActiveRecord::Migration
  def change
    add_column :initiatives, :last_comment_at, :datetime
    add_column :antraeges, :last_comment_at, :datetime
    add_column :constructions, :last_comment_at, :datetime
    add_column :blogs, :last_comment_at, :datetime
  end
end
