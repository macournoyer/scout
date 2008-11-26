module Scout
  module Listeners
    class Hungry < Scout::Listener
      reacts_to "hungry"
      reacts_to "hungary"
      reacts_to "starving"
      
      def process
        run_command :lunchstatus
      end
    end
  end
end