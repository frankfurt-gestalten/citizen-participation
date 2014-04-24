class SitemapController < ApplicationController
   def index
      redirect_to "http://files.frankfurt-gestalten.de/sitemaps/sitemap.xml.gz"
   end
end