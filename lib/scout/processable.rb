module Scout
  class CommandError < RuntimeError; end
  
  module Processable
    def process
      raise StandardError, "Oh plz plz, implement #{self.class}\#process"
    end
    
    def process!
      process
    rescue CommandError
      speak "Error: " + $!.message
    rescue Object
      speak "Error processing #{self.class.name}: #{$!.message}"
      log "#{$!}\n\t" + $!.backtrace.join("\n\t")
    end
    
    def room
      @bot.room
    end
    
    def data
      @bot.data[self.class.name] ||= {}
    end
    
    def config
      @bot.config
    end
    
    def speak(message)
      @bot.room.speak message
    end
    
    def paste(message)
      @bot.room.paste message
    end
    
    def log(message)
      @bot.log message
    end
    
    def run_command(trigger, *args)
      Command.find(trigger).new(from, bot, trigger, args).process!
    end
  end
end