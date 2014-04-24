atom_feed do |feed|
  feed.title "Frankfurt Gestalten Kommentare"
  feed.updated @comments.maximum(:updated_at)

  @comments.each do |comment|
    feed.entry comment.commentable, published: comment.created_at do |entry|
      if comment.commentable_type == 'Construction'
        typ = 'Baustelle'
      elsif comment.commentable_type == 'Antraege'
        typ = 'Antrag'
      else
        typ = comment.commentable_type
      end
      entry.title "#{typ}: #{comment.commentable.title}"
      entry.content truncate(strip_links(comment.content.gsub(/http?:\/\/[\S]+/, '')), :length => 140)
      entry.author do |author|
        author.name comment.user.try(:username)
      end
    end
  end
end