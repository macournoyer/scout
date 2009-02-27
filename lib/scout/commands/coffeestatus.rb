module Scout
  module Commands
    class CoffeeStatus < Scout::Command
      trigger :coffeestatus
      trigger :cs
      help    "Figure out how much coffee to brew"
      
      def usage
        <<-EOS
Update your cofeestatus:
  @#{bot.name} coffeestatus | cs <status>
Start over:
  @#{bot.name} coffeestatus | cs clear
EOS
      end
      
      def statuses
        data[:statuses] ||= {}
      end
      
      def process
        if args.empty?
          paste [statuses_message].flatten.join("\n")
        elsif args.first == "help"
          paste usage
        elsif args.first == "clear"
          statuses.clear
        else
          statuses[from] = args.join(" ")
        end
      end
      
      def statuses_message
        out = []
        out << "Hu wanz cawfee?"
        statuses.each_pair do |person, coffee|
          out << "  #{person}: #{coffee}"
        end
        out << "Total: #{statuses.size}" unless statuses.empty?
        out
      end
    end
  end
end
