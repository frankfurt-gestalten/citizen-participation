xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Your Blog Title"
    xml.description "A blog about software and chocolate"
    xml.link constructions_url

    for post in @constructions
      xml.item do
        xml.title "#{l post.start_date, :format => :short}-#{l post.end_date, :format => :short}: #{post.title}"
        xml.description post.description_long
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link construction_url(post)
        #xml.guid post_url(post)
      end
    end
  end
end
