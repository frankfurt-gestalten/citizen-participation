atom_feed do |feed|
  feed.title "Frankfurt Gestalten Anträge"
  feed.updated @antraeges.maximum(:updated_at)

  @antraeges.limit(50).each do |antraege|
    feed.entry antraege, published: antraege.datum do |entry|
      entry.title antraege.title
      entry.content sanitize(antraege.content)
      entry.author do |author|
        author.name antraege.partei
      end
    end
  end
end