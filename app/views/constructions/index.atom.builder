atom_feed do |feed|
  feed.title "Baustellen"
  feed.updated @constructions.maximum(:updated_at)

  @constructions.limit(20).each do |construction|
    title = "#{l construction.start_date, :format => :short}-#{l construction.end_date, :format => :short}: #{construction.title}"
    feed.entry construction, published: construction.created_at do |entry|
      entry.title title
      entry.content construction.description_long
      entry.author do |author|
        author.name 'mainziel'
      end
    end
  end
end