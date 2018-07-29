class ItemCreator
  require 'net/http'
  
  HOST_URL = "https://news.ycombinator.com"
  def self.parse_fetch_items(url)
    response = nil
    begin
      uri = URI(url)
      response = Net::HTTP.get(uri)
      parse_and_create_items(response)
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError, Net::HTTPInternalServerError,
      Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError, Net::HTTPClientError => e
       Rails.logger.error(e)
       puts "An error has occured: #{e}"
    end
  end
  
  def self.parse_and_create_items(response)
    puts "in parse_and_create_items"
    html_doc = Nokogiri::HTML(response)
    html_doc.css("table#hnmain").css("tr.athing").each do |ele|
      #Get required data from pages
      upvotes = ele.next.css("span").first.text.gsub(" points", "").gsub(" point", "").to_i
      comments = ele.next.css("a").last.text.gsub(" comments", "").gsub(" comment", "").gsub("discuss", "").to_i
      ref_id = ele.attr("id").to_i
      
      #Get existing/new item
      item = Item.where(ref_id: ref_id).first
      item = Item.new if item.blank?
      if item.id.present?
        item.upvotes = upvotes if item.upvotes != upvotes && upvotes.present? && upvotes != 0
        item.comments = comments if item.comments != comments && comments.present? && comments != 0
      else
        #Get required data from pages
        title = ele.css("td.title a").children.first.text
        url = ele.css("td.title a").attr("href").value
        hacker_url = URI.join(HOST_URL, ele.next.css("a").last.attr("href")).to_s
        posted_on = get_time_from_string ele.next.css("span.age").text.strip
        
        item.assign_attributes ({ title: title, url: url, hacker_url: hacker_url, posted_on: posted_on,
          ref_id: ref_id, upvotes: upvotes, comments: comments })
      end
      
      if item.changed? && item.save
        puts "Item id:#{item.id} ref_id:#{ref_id} has been added/modified"
      else
        if item.errors.present?
        end
        puts "Item id:#{item.id} ref_id:#{ref_id} has not been modified" if item.id.present?
        puts "Item for ref_id:#{ref_id} encountered errors" if item.id.blank?
      end
    end
  end

  def self.get_time_from_string(time_text)
    return Time.now - 1.year if !/^\d+\s+(day|days|hour|hours|minute|minutes)\s+ago$/.match?(time_text)
    time_components = time_text.split(" ")
    case time_components[1]
    when "hour", "hours"
      return Time.now - time_text[0].to_i.hour
    when "minute", "minutes"
      return Time.now - time_text[0].to_i.minute
    when "day", "days"
      return Time.now - time_text[0].to_i.day
    else
      return Time.now - 1.year
    end
  end
  
end