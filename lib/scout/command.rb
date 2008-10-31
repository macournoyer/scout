module Scout
  class Command
    attr_reader :from, :bot, :command, :args
    
    COMMANDS = {}
    DESCRIPTIONS = {}
    
    class << self
      def parse(message, bot)
        if tokens = tokenize!(message, bot)
          person, command, args = *tokens
          command_class = COMMANDS[command] || Scout::Commands::Invalid
          command_class.new(person, bot, command, args)
        end
      end
      
      def tokenize!(message, bot)
        full, command, args = message[:message].match(/^#{bot.name}: (\w+)\s?((?:.+\s?)*)$/i).to_a
        [message[:person], command, args.split] if command
      end
      
      def trigger(name)
        COMMANDS[name.to_s] = self
      end
      
      def help(value)
        DESCRIPTIONS[self] = value
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
    
    def process!
      process
    rescue
      speak "Error processing command: #{$!.message}"
      puts "#{$!}\n\t" + $!.backtrace.join("\n\t")
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