require "open-uri"
require "hpricot"
require "timeout"
require "text/format"

module Scout
  module Listeners
    class UrlListener < Scout::Listener
      LINK_RE = %r(href=\\"(.*?)\\")
      # Disable for now, causes BUS error in Hpricot
      # reacts_to LINK_RE
      
      def process
        url = message[LINK_RE, 1]
        log "> #{url}"
        case url
        when %r(twitter\.com.+/status(es)?/.+)i
          tweet_content = extract_tweet_content(url)
          unless tweet_content.blank?
            paste Text::Format.new(:text => tweet_content, :first_indent => 0).paragraphs
          end
        when %r(github\.com.+/tree/master)i
          github_description = extract_github_description(url)
          unless github_description.blank?
            paste Text::Format.new(:text => github_description, :first_indent => 0).paragraphs
          end
        else
          page_title = extract_page_title(url)
          unless page_title.blank?
            speak "Last link: #{page_title}"
          end
        end
      end
      
      def extract_page_title(url)
        extract_html_content url, ":title"
      end
      
      def extract_tweet_content(url)
        extract_html_content url, 'span.entry-content'
      end
      
      def extract_github_description(url)
        extract_html_content url, 'span#repository_description'
      end
      
      def extract_html_content(url, hpricot_matcher)
        return nil unless url
        Timeout.timeout(2) do
          doc = Hpricot(open(url))
          (doc/hpricot_matcher).inner_text
        end
      rescue Exception
        nil
      end

    end
  end
end