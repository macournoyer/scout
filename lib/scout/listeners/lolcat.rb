module Scout
  module Listeners
    class Lolcat < Scout::Listener
      reacts_to "lolcat"
      
      def process
        run_command :lolcat
      end
    end
  end
end