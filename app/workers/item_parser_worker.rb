class ItemParserWorker
  include Sidekiq::Worker

  def perform(url)
    puts "Accessing #{url} for new/existing items"
    ItemCreator.parse_fetch_items(url)
  end
end
