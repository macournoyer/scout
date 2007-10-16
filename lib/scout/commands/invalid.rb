module Scout
  module Commands
    class Invalid < Scout::Command
      def process
        speak "Invalid command : #{command}"
      end
    end
  end
end