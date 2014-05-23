atom_feed do |feed|
  feed.title "Frankfurt Gestalten Blog"
  feed.updated @blogs.maximum(:updated_at)

  @blogs.limit(20).each do |post|
    feed.entry post, published: post.created_at do |entry|
      entry.title post.title
      entry.content post.content
      entry.author do |author|
        author.name post.user.username
      end
    end
  end
end