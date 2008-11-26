module Scout
  module Listeners
    class Smash < Scout::Listener
      reacts_to "smash"
      
      def process
        run_command :smash
      end
    end
  end
end