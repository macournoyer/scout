require "open-uri"
require "hpricot"
require "timeout"

module Scout
  module Listeners
    class UrlTitle < Scout::Listener
      LINK_RE = /href=\\"(.*?)\\"/
      reacts_to LINK_RE
      
      def process
        page_title = extract_page_title(message[LINK_RE, 1])
        unless page_title.blank?
          speak "Last link: #{page_title}"
        end
      end
      
      def extract_page_title(url)
        return nil unless url
        Timeout.timeout(2) do
          doc = Hpricot(open(url))
          (doc/:title).inner_html
        end
      rescue Exception
        nil
      end
    end
  end
end