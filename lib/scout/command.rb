module Scout
  class Command
    include Processable
    
    attr_reader :from, :bot, :command, :args
    
    COMMANDS = {}
    DESCRIPTIONS = {}
    
    class << self
      def trigger(name)
        COMMANDS[name.to_s] = self
      end
      
      def help(value)
        DESCRIPTIONS[self] = value
      end

      def parse(message, bot)
        if tokens = tokenize!(message, bot)
          person, command, args = *tokens
          command_class = find(command)
          command_class.new(person, bot, command, args)
        end
      end
      
      def tokenize!(message, bot)
        full, command, args = message[:message].match(/^@?#{bot.name}:? (\w+)\s?((?:.+\s?)*)$/i).to_a
        [message[:person], command, args.split] if command
      end
      
      def find(trigger)
        COMMANDS[trigger.to_s] || Scout::Commands::Invalid
      end
    end
        
    def initialize(from, bot, command, args)
      @from = from
      @bot = bot
      @command = command
      @args = args
    end
  end
end