require "rest_client"
require "hpricot"

module Scout
  module Commands
    class Tweet < Scout::Command
      trigger :tweet
      help    "Sent an update to twitter"
      
      def twitter_config
        config[:twitter] || raise(CommandError, "No twitter configuration")
      end
      
      def process
        doc = Hpricot(update_tweet(args.join(" ")))
        id = (doc/:status/:id).first.innerHTML
        speak "http://twitter.com/#{twitter_config[:username]}/status/#{id}"
      end
      
      def update_tweet(status)
        resource = RestClient::Resource.new("http://twitter.com/statuses/update.xml", twitter_config[:username], twitter_config[:password])
        resource.post(:status => status, :source => 'scout', :content_type => 'application/xml', :accept => 'application/xml')
      end
    end
  end
end
