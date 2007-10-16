module Scout
  module Commands
    class Help < Scout::Command
      def process
        paste "=== Scout Chat Bot ===\n" +
              "To send a command type:\n" +
              "  @#{bot.name} command [arguments]\n\n" +
              "Available commands:\n" +
              " say text               (speak throught the bot)\n" +
              " vote start|stop|+1|-1  (count votes)\n" +
              " define word            (search for definitions)\n" +
              " help                   (show this help message)"
      end
    end
  end
end