require 'nokogiri'
require 'httparty'
require 'pry'

page = HTTParty.get('https://scrapeme.live/shop/')

parsed_page = Nokogiri::HTML(page)
# Pry.start(binding)

pokemons = {}

products = parsed_page.css("ul[class='products columns-4']")
products = products.css('li')

names = products.css("h2[class='woocommerce-loop-product__title']")
prices = products.css('span.price')
skus = products.css('a')
images = products.css('img')

for i in 0...products.length do
  pokemons[i] = {
    id: i,
    name: names[i].text,
    price: prices[i].text,
    sku: skus[i]['data-product_sku'],
    img: images[i]['src']
  }
end

puts pokemons.to_h

File.write('./result.json', JSON.dump(pokemons.to_h))
