module Scout
  module Processable
    def process
      raise StandardError, "Oh plz plz, implement #{self.class}\#process"
    end
    
    def process!
      process
    rescue Object
      speak "Error processing #{self.class.name}: #{$!.message}"
      puts "#{$!}\n\t" + $!.backtrace.join("\n\t")
    end
    
    def room
      @bot.room
    end
    
    def data
      @bot.data[self.class.name] ||= {}
    end
    
    def config
      @bot.config[self.class.name] ||= {}
    end
    
    def speak(message)
      @bot.room.speak message
    end
    
    def paste(message)
      @bot.room.paste message
    end
    
    def run_command(trigger, *args)
      Command.find(trigger).new(from, bot, trigger, args).process!
    end
  end
end