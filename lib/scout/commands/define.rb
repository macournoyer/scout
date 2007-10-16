require 'open-uri'

module Scout
  module Commands
    class Define < Scout::Command
      def process
        url = "http://www.google.com/search?q=define:#{args.join('+')}"
        out = open(url).read.scan(/<li>(.*?)<\li>/m).flatten
    		out.each { |s| s.gsub!(/<.*?>/m, ' ') }
        
        speak "Definitions from #{url} :"
        speak '-None-' if out.empty?
        out.each do |definition|
          speak definition
        end
      end
    end
  end
end