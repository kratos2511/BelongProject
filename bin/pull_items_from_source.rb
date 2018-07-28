# Update Items
#*/10 * * * * /bin/bash -l -c 'cd /Users/mazdigital/Desktop/project/BelongProject ; bundle exec rails runner -e development bin/pull_items_from_source.rb >> log/pull_items_from_source.log'
puts "*"*100
base_uri = "https://news.ycombinator.com/news?p="
(1..3).each do |i| 
  ItemParserWorker.perform_async(base_uri+i.to_s)
end

puts "Item update/fetch queued at #{Time.now}"
puts "*"*100