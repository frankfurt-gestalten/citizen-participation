
task :import_abgeordnetenwatch => :environment do
  urls = ['http://www.abgeordnetenwatch.de/koop/feeds/index.php?account=531a29d63de0493190b442b04ce5ec3d&feed=d5e267101d191abe5ef16cf458633f8f&cmd=393']
  urls.each do |url|
    uri = URI(url)
    request = Net::HTTP::Get.new(uri)
    response = Net::HTTP.start(uri.hostname, uri.port) do |conn|
      conn.request(request)
    end

    doc = Nokogiri::XML(response.body)
    doc.search('item').each do |item|
      puts item.search('pubDate').first.content
      Question.create_from_feed(item)
    end
  end
end