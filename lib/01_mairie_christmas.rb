
require 'open-uri'
require 'nokogiri'

url = 'https://lannuaire.service-public.fr/ile-de-france/val-d-oise/55e63c96-f8a4-424c-a9fd-52ddf515b6ef'
page = Nokogiri::HTML(URI.open(url))

def extract_townhall_email(page)
  array_with_email = Array.new
  page.xpath('//ul//li//span//a[contains(@class,"send-mail")]').each do |email|
    array_with_email << email.text
  end
  return array_with_email
end

puts extract_townhall_email(page)




