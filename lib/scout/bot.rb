module Scout
  class InvalidRoom < StandardError; end
  
  class Bot
    attr_accessor :name, :room
    
    def initialize(room, options={})
      raise InvalidRoom, 'You need to supply a Tinder::Room object' unless room.is_a? Tinder::Room
      @room     = room
      @name     = options[:name] || 'bot'
      @sleep    = options[:sleep] || 1
      @continue = true
    end
    
    def listen!
      trap("INT") do
        puts "Stoping ..."
        @continue = false
        @room.leave
      end
      
      while @continue
        @room.join
        process_commands
        sleep @sleep
      end
    end
    
    def process_commands
      fetch_commands.each do |command|
        command.process! if command
      end
    end
    
    def fetch_commands
      @room.listen.collect do |message|
        puts message[:person] + ": " + message[:message]
        Command.parse(message, self)
      end
    end
  end
end