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
      
      puts "Starting the bot, CTRL+C to stop ..."
      while @continue
        @room.join
        messages = fetch_messages
        process_commands(messages)
        notify_listeners(messages)
        sleep @sleep
      end
    end
    
    def process_commands(messages)
      messages.each do |message|
        command = Command.parse(message, self)
        command.process! if command
      end
    end
    
    def notify_listeners(messages)
      messages.each do |message|
        listeners = Listener.notify(message, self)
        listeners.each { |listener| listener.process! }
      end
    end
    
    def fetch_messages
      @room.listen.map do |message|
        puts message[:person] + ": " + message[:message]
        message
      end
    end
  end
end