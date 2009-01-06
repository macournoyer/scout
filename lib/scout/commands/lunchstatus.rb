module Scout
  module Commands
    class Lunchstatus < Scout::Command
      trigger :lunchstatus
      trigger :ls
      help    "Compile lunch statuses"
      
      def usage
        <<-EOS
Update your lunchstatus:
  @#{bot.name} lunchstatus <status>
Suggest a place:
  @#{bot.name} lunchstatus + <place name>
Start over:
  @#{bot.name} lunchstatus clear
EOS
      end
      
      def statuses
        data[:statuses] ||= {}
      end
      
      def places
        data[:places] ||= []
      end
      
      def process
        if args.empty?
          paste [places_message, statuses_message].flatten.join("\n")
        elsif args.first == "help"
          paste usage
        elsif args.first == "reset"
          statuses.clear
        elsif args.first == "clear"
          places.clear
          statuses.clear
        elsif args.first == "+"
          places << args[1..-1].join(" ")
        else
          statuses[from] = args.join(" ")
        end
      end
      
      def places_message
        out = []
        out << "Where to lunch?"
        if places.empty?
          out << "  (Suggest some place to eat: @#{bot.name} lunchstatus + batcave)"
        end
        places.each do |place|
          out << "  #{place}"
        end
        out
      end
      
      def statuses_message
        out = []
        out << "Statuses:"
        statuses.each_pair do |person, lonche|
          out << "  #{person}: #{lonche}"
        end
        out
      end
    end
  end
end
