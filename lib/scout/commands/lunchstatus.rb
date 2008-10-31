module Scout
  module Commands
    class Lunchstatus < Scout::Command
      trigger :lunchstatus
      help    "Compile lunch statuses"
      
      
      START_MSG = <<EOS
/---------------------------\\
|        LUNCHSTATUS        |
+---------------------------+
|       U HAS LONCHE?       |
|        > oh course        |
|        > noz              |
|        > wa???            |
|        > smash            |
|        > LVS              |
\\---------------------------/
EOS
      @@lonches = {}
      
      def process
        if args.empty?
          paste START_MSG
          summary
        elsif args.first == "clear"
          @@lonches.clear
        else
          @@lonches[from] = args.join(" ")
        end
      end
      
      def summary
        @@lonches.each_pair do |person, lonche|
          speak "#{person}: #{lonche}"
        end
      end
    end
  end
end
