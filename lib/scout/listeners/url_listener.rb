require "open-uri"
require "hpricot"
require "timeout"
require "text/format"

module Scout
  module Listeners
    class UrlListener < Scout::Listener
      LINK_RE = /href=\\"(.*?)\\"/
      reacts_to LINK_RE
      
      def process
        case message[LINK_RE, 1]
        when /twitter\.com.+status.+/i
          tweet_content = extract_tweet_content(message[LINK_RE, 1])
          unless tweet_content.blank?
            paste Text::Format.new(:text => tweet_content).paragraphs
          end
        when %r(github\.com.+/tree/master)i
          github_description = extract_github_description(message[LINK_RE, 1])
          unless github_description.blank?
            paste Text::Format.new(:text => github_description).paragraphs
          end
        else
          page_title = extract_page_title(message[LINK_RE, 1])
          unless page_title.blank?
            speak "Last link: #{page_title}"
          end
        end
      end
      
      def extract_page_title(url)
        extract_html_content(url, ':title')
      end
      
      def extract_tweet_content(url)
        extract_html_content(url, 'span.entry-content')
      end
      
      def extract_github_description(url)
        extract_html_content(url, 'span#repository_description')
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