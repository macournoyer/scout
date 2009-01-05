module Scout
  module Commands
    class Lunchstatus < Scout::Command
      trigger :lunchstatus
      trigger :ls
      help    "Compile lunch statuses"
      
      def usage
        <<-EOS
== lunchstatus beta 2 ==

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
          paste usage
          display_places
          display_statuses
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
      
      def display_places
        speak "> I has lonche"
        if places.empty?
          speak "Suggest some place to eat: @#{bot.name} lunchstatus + batcave"
        end
        places.each do |place|
          speak "> #{place}"
        end
      end
      
      def display_statuses
        statuses.each_pair do |person, lonche|
          speak "#{person}: #{lonche}"
        end
      end
    end
  end
end
