require "open-uri"
require "hpricot"

module Scout
  module Commands
    class You < Scout::Command
      trigger :you
      trigger :ohaie
      help    "compliment the bot"
      
      def process
        speak "#{from}: no you #{args.join(' ')}"
      end
    end
  end
end