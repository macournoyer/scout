require "open-uri"
require "hpricot"

module Scout
  module Commands
    class Fail < Scout::Command
      trigger :fail
      help    "Show an image from failblog.com"
      
      def process
        speak random_image_url
      end
      
      def random_image_url
        doc = Hpricot(open('http://failblog.org/?random'))
        (doc/'div.snap_preview img').first.attributes['src'].gsub(/\?.*/, "")
      end
    end
  end
end
