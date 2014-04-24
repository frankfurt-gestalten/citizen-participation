require 'rss'

task :update_feeds => :environment do
  urls = ['http://www.klenkes.de/calendar.xml']
  urls.each do |url|
    uri = URI(url)
    request = Net::HTTP::Get.new(uri)
    request.basic_auth 'export', '40vj2Vsf8emncvIozTtADuFEFlb6RDwi'
    response = Net::HTTP.start(uri.hostname, uri.port) do |conn|
      conn.request(request)
    end

    doc = Nokogiri::XML(response.body)
    doc.search('event').each do |event|
      Neuigkeiten.create_from_xml('Calendar', event)
    end

    #feed = RSS::Parser.parse(response.body, false)
    #feed.items.each do |item|
    #  Neuigkeiten.create_from_feed(feed.channel.title, item)
    #end
  end
end