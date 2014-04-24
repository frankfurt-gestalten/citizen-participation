
task :import_meldungen => :environment do
  urls = ['http://frankfurt-gestalten.s3.amazonaws.com/traffic/meldungen.xml']
  urls.each do |url|
    uri = URI(url)
    request = Net::HTTP::Get.new(uri)
    response = Net::HTTP.start(uri.hostname, uri.port) do |conn|
      conn.request(request)
    end

    doc = Nokogiri::XML(response.body)
    doc.search('Ereignis').each do |item|
      Construction.create_from_xml(item, "meldung")
      puts item
    end
  end
end