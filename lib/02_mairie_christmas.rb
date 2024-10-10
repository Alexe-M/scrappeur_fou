
## Une fois que tu sais le faire pour une mairie, tu vas vouloir industrialiser et répéter ça sur tout l'annuaire du Val d'Oise. La prochaine étape est de coder une méthode get_townhall_urls qui récupère les URLs de chaque ville du Val d'Oise.

require 'rubygems'
require 'open-uri'
require 'nokogiri'

url = 'https://lannuaire.service-public.fr/navigation/ile-de-france/val-d-oise/mairie'
page = Nokogiri::HTML(URI.open(url))

def extract_townhalls_info(page)
  townhall_urls_array = []
  townhall_name_array = []

  page.xpath('//*/a[contains(@class,"fr-link")]').each do |url|
    townhall_urls_array << url['href']
    townhall_name_array << url.text.gsub("Mairie - ", "")
  end
  return  townhall_name_array.drop(4), townhall_urls_array.drop(4)
end

def extract_townhall_email(townhall_urls_array)
  townhall_emails_array = []

  townhall_urls_array.each do |url|
    page = Nokogiri::HTML(URI.open(url))

    email = page.xpath('//ul//li//span//a[contains(@class,"send-mail")]').text
    if email.empty?
      townhall_emails_array << "Pas d'email trouvé"
    else
      townhall_emails_array << email
    end
  end
  return townhall_emails_array
end

def create_hash (townhall_name_array,townhall_emails_array)
  townhalls_hash = {}
  townhall_name_array.zip(townhall_emails_array) {|name, email|townhalls_hash[name]=email}
  return townhalls_hash
end

def execute (page)
  townhall_name_array, townhall_urls_array = extract_townhalls_info(page)

  townhall_emails_array = extract_townhall_email(townhall_urls_array)

  townhalls_hash = create_hash(townhall_name_array,townhall_emails_array)
  puts townhalls_hash

end

execute(page)





## Deuxième méthode

  # require 'rubygems'
  # require 'nokogiri'
  # require 'open-uri'
  # require 'pry'

  # def get_townhall_email(townhall_url)
  #   doc = Nokogiri::HTML(URI.open(townhall_url))
  #   mail = doc.css('.send-mail').text 
  #   mail
  # end

  # def get_townhall_urls(numero)
  #   doc = Nokogiri::HTML(URI.open("https://lannuaire.service-public.fr/navigation/ile-de-france/val-d-oise/mairie?page=#{numero}"))
  #   ville = doc.css('a.fr-link').map { |node| node.text.gsub("Mairie - ", "") } .drop(4)
  #   townhall_url = doc.css('a.fr-link').map { |node| node['href'] } .drop(4)
  #   townhall_email = townhall_url.map { |lien| get_townhall_email(lien)}
  #   hash = ville.zip(townhall_email).to_h
  # end

  # hash={}
  # 7.times do |i|
  #   hash=hash.merge(get_townhall_urls(i+1))
  # end

  # puts hash

