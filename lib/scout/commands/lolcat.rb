require "open-uri"
require "hpricot"

module Scout
  module Commands
    class Lolcat < Scout::Command
      trigger :lolcat
      help    "Show an image from icanhascheezburger.com"
      
      def process
        speak random_image_url
      end
      
      def random_image_url
        doc = Hpricot(open('http://icanhascheezburger.com/?random'))
        (doc/'div.snap_preview img').first.attributes['src'].gsub(/\?.*/, "")
      end
    end
  end
end
