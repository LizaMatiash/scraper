# ruby -I test spec/unit/web_scraper_spec.rb

require 'nokogiri'
require 'httparty'
require 'pry'
require 'test/unit'

class WebScraperSpec < Test::Unit::TestCase
  page = HTTParty.get('https://scrapeme.live/shop/')

  test 'page is accessible' do
    assert( page )
  end

  parsed_page = Nokogiri::HTML(page)
  products = parsed_page.css("ul[class='products columns-4']")
  products = products.css('li')
  names = products.css("h2[class='woocommerce-loop-product__title']")

  test 'right names amount' do
    assert( names.length == 16 )
  end

end
