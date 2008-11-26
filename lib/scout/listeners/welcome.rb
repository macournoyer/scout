module Scout
  module Listeners
    class Welcome < Scout::Listener
      reacts_to "has entered the room"
      
      def process
        return if from.downcase == "bot"
        speak "#{from}: ohaie! how are you?"
      end
    end
  end
end