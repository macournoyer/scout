module Scout
  module Commands
    class Is < Scout::Command
      trigger :is
      help    "Ask anything!"
      
      def process
        speak "#{from}: yes"
      end
    end
  end
end