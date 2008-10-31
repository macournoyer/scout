module Scout
  module Commands
    class You < Scout::Command
      trigger :you
      help    "compliment the bot"
      
      def process
        speak "oh thx #{from}"
      end
    end
  end
end