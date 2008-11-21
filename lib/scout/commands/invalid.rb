module Scout
  module Commands
    class Invalid < Scout::Command
      REPLIES = [
        "Sh!",
        "Sh!",
        "Sh!... Knock-knock.",
        "Sh!",
        "Let me tell you a little story about a man named Sh! Sh! even before you start. That was a pre-emptive 'sh!' Now, I have a whole bag of 'sh!' with your name on it."
      ]
      @@current_reply = 0
      
      def process
        speak "#{from}: " + REPLIES[@@current_reply]
        @@current_reply += 1
        @@current_reply = 0 if @@current_reply >= REPLIES.size
      end
    end
  end
end