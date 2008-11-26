module Scout
  module Listeners
    class Fail < Scout::Listener
      reacts_to "FAIL"
      
      def process
        run_command :fail
      end
    end
  end
end