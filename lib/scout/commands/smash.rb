module Scout
  module Commands
    class Smash < Scout::Command
      trigger :smash
      help    "Smash someone"
      
      ASCII = <<-EOS
 .d8888b.  888b     d888        d8888  .d8888b.  888    888 888 
d88P  Y88b 8888b   d8888       d88888 d88P  Y88b 888    888 888 
Y88b.      88888b.d88888      d88P888 Y88b.      888    888 888 
 "Y888b.   888Y88888P888     d88P 888  "Y888b.   8888888888 888 
    "Y88b. 888 Y888P 888    d88P  888     "Y88b. 888    888 888 
      "888 888  Y8P  888   d88P   888       "888 888    888 Y8P 
Y88b  d88P 888   "   888  d8888888888 Y88b  d88P 888    888  "  
 "Y8888P"  888       888 d88P     888  "Y8888P"  888    888 888
EOS
      
      def process
        speak args.first + ": " if args.first
        paste ASCII
      end
    end
  end
end