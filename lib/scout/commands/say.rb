module Scout
  module Commands
    class Say < Scout::Command
      trigger :say
      help    "Make bot talk"
      
      def process
        speak args.join(' ')
      end
    end
  end
end