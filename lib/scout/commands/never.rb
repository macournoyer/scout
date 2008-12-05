module Scout
  module Commands
    class Never < Scout::Command
      trigger :never
      help    "Rickroll"
      
      LINES = [
        # "never gonna give you up",
        "never gonna let you down",
        "never gonna run around and desert you",
        "never gonna make you cry", 
        "never gonna say goodbye", 
        "never gonna tell a lie and hurt you"
      ]
      
      def process
        if defined?(@@last_time) && Time.now - @@last_time < 2.minutes
          speak "I'm too tired to sing sorry..."
        else
          @@last_time = Time.now
          LINES.each do |line|
            speak line
            sleep 3
          end
        end
      end
    end
  end
end