module Scout
  module Commands
    class Help < Scout::Command
      trigger :help
      help    "Show this"
      
      def process
        out = returning [] do |p|
          p << "@#{bot.name} <command> [arguments]"
          p << ""
          p << "Available commands:"
          COMMANDS.each_pair do |name, klass|
            p << name.ljust(14) + DESCRIPTIONS[klass]
          end
        end
        paste out.join("\n")
      end
    end
  end
end
