# Update Items
#*/10 * * * * /bin/bash -l -c 'cd /Users/mazdigital/Desktop/project/BelongProject ; bundle exec rails runner -e development bin/pull_items_from_source.rb >> log/pull_items_from_source.log'
puts "*"*100
puts "Items fetching started at #{Time.now}"



response = nil
uri = URI("https://news.ycombinator.com/")

Net::HTTP.start(uri.host, uri.port,
  :use_ssl => uri.scheme == 'https') do |http|
  request = Net::HTTP::Get.new uri

  response = http.request request # Net::HTTPResponse object
end

if response.class.name = "Net::HTTPOK"
  puts "Top stories  #{Time.now}"
else 
  
end

puts "Feed Stores update finished at #{Time.now}"
puts "*"*100