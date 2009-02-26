module Scout
  module Listeners
    class CoffeeGreeter < Scout::Listener
      reacts_to "has entered the room"
      
      def process
        return if from.downcase == "bot"
        return unless from.match(/alexandra/i)
        speak "#{@bot.name} coffeestatus clear"
        speak "#{@bot.name} coffeestatus"
      end
      
    end
  end
end