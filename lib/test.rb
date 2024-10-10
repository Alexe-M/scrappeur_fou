
def scrap_prices(page)

  crypto_prices_array = Array.new

  page.xpath('//td[contains(@class, "cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price")]').each do |price|
   crypto_prices_array << price.text
  end
  puts crypto_prices_array
  return crypto_prices_array
end

scrap_prices(page)