module Scout
  class Command
    attr_reader :from, :bot, :command, :args
    
    class << self
      def parse(message, bot)
        if tokens = tokenize!(message, bot)
          person, command, args = *tokens
          command_class = begin
            # TODO make this more secure
            "Scout::Commands::#{command.classify}".constantize
          rescue NameError => e
            Scout::Commands::Invalid
          end
          
          command_class.new(person, bot, command, args)
        end
      end
    
      def tokenize!(message, bot)
        full, command, args = message[:message].match(/^@#{bot.name} (\w+)\s?((?:.+\s?)*)$/i).to_a
        [message[:person], command, args.split] if command
      end
    end
        
    def initialize(from, bot, command, args)
      @from = from
      @bot = bot
      @command = command
      @args = args
    end
    
    def process
    end
    
    def room
      @bot.room
    end
    
    def speak(message)
      @bot.room.speak message
    end
    
    def paste(message)
      @bot.room.paste message
    end
  end
end