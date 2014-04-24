atom_feed do |feed|
  feed.title "Frankfurt Gestalten Initiativen short"
  feed.updated @initiatives.maximum(:updated_at)

  @initiatives.limit(20).each do |initiative|
    feed.entry initiative, published: initiative.created_at do |entry|
      entry.title initiative.title
      entry.content truncate(initiative.content, :length => 140)
      entry.author do |author|
        author.name initiative.user.username
      end
    end
  end
end