module Scout
  module Commands
    class IsIt < Scout::Command
      trigger :"is it"
      help    "Ask anything!"
      
      def process
        speak "#{from}: yes, it's #{args.join(' ')}"
      end
    end
  end
end