SitemapGenerator::Sitemap.default_host = "http://www.frankfurt-gestalten.de"
SitemapGenerator::Sitemap.sitemaps_host = "https://s3-eu-west-1.amazonaws.com/my-frankfurt-gestalten/"
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new
SitemapGenerator::Sitemap.create do
  add '/', :changefreq => 'daily', :priority => 0.9
  Initiative.find_each do |initiative|
    add initiative_path(initiative), lastmod: initiative.updated_at
  end
  Antraege.find_each do |antraege|
    add antraege_path(antraege), lastmod: antraege.updated_at
  end
  for i in 1..43 do
    add '/stadtteil/' + i.to_s, :changefreq => 'daily', :priority => 0.8
  end
end