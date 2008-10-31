require "rest_client"
require "hpricot"

module Scout
  module Commands
    class Tweet < Scout::Command
      USERNAME = "mtl_on_rails"
      PASSWORD = "mtl_on_rails"
      
      trigger :tweet
      help    "Sent an update to #{USERNAME} twitter"
      
      def process
        doc = Hpricot(update_tweet(args.join(" ")))
        id = (doc/:status/:id).first.innerHTML
        speak "http://twitter.com/#{USERNAME}/status/#{id}"
      end
      
      def update_tweet(status)
        resource = RestClient::Resource.new("http://twitter.com/statuses/update.xml", USERNAME, PASSWORD)
        resource.post(:status => status, :source => 'Standout Jobs', :content_type => 'application/xml', :accept => 'application/xml')
      end
    end
  end
end
