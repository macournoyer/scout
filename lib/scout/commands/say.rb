module Scout
  module Commands
    class Say < Scout::Command
      def process
        speak args.join(' ')
      end
    end
  end
end