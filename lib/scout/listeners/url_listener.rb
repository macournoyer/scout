require "open-uri"
require "hpricot"
require "timeout"
require "text/format"

module Scout
  module Listeners
    class UrlListener < Scout::Listener
      LINK_RE = /href=\"(.*?)\"/
      reacts_to LINK_RE
      
      def process
        if message[LINK_RE, 1].match(/twitter\.com/i)
          tweet_content = extract_tweet_content(message[LINK_RE, 1])
          unless tweet_content.blank?
            paste Text::Format.new(:text => tweet_content).paragraphs
          end
        else
          page_title = extract_page_title(message[LINK_RE, 1])
          unless page_title.blank?
            speak "Last link: #{page_title}"
          end
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
      
      def extract_tweet_content(url)
        extract_html_content(url, 'span.entry-content')
      end
      
      def extract_html_content(url, hpricot_matcher)
        return nil unless url
        Timeout.timeout(2) do
          doc = Hpricot(open(url))
          (doc/hpricot_matcher).inner_html
        end
      rescue Exception
        nil
      end

    end
  end
end