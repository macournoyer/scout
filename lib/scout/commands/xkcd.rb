require "open-uri"
require "hpricot"

module Scout
  module Commands
    class Xkcd < Scout::Command
      trigger :xkcd
      help    "Show a random pic from xkcd"
      
      def process
        speak random_image_url
      end
      
      def random_image_url
        doc = Hpricot(open('http://dynamic.xkcd.com/comic/random/'))
        (doc/'div.s img')[1].attributes['src']
      end
    end
  end
end
