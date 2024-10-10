

require 'open-uri'
require 'nokogiri'

url = 'https://coinmarketcap.com/all/views/all/'
page = Nokogiri::HTML(URI.open(url))

def scrap_names(page)

  crypto_names_array = Array.new

  page.xpath('//td[contains(@class, "cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--hide-sm cmc-table__cell--sort-by__symbol")]').each do |name|
    crypto_names_array << name.text
  end
  return crypto_names_array
end

def scrap_prices(page)

  crypto_prices_array = Array.new

  page.xpath('//td[contains(@class, "cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price")]').each do |price|
   crypto_prices_array << price.text
  end
  return crypto_prices_array
end


def create_hash(crypto_names_array,crypto_prices_array)
  crypto_hash = {}
  crypto_names_array.zip(crypto_prices_array) {|name,price|crypto_hash[name.to_sym]= price}
  return crypto_hash
end

def execute(page)
crypto_names_array = scrap_names(page)
puts crypto_names_array

crypto_prices_array = scrap_prices(page)
puts crypto_prices_array

crypto_hash = create_hash(crypto_names_array,crypto_prices_array)
puts crypto_hash
end

execute (page)


# Deuxième méthode 
doc = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
hash={}
cryptos=doc.xpath("//tr/td[2]/div/a[2]").map {|crypto| crypto.text }
valeurs=doc.xpath("//tr/td[5]/div/span").map {|crypto| crypto.text }
hash = cryptos.zip(valeurs).to_h
puts hash


