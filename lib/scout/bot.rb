module Scout
  class InvalidRoom < StandardError; end
  
  class Bot
    attr_accessor :name, :room, :config, :data
    
    def initialize(room, options={})
      raise InvalidRoom, 'You need to supply a Tinder::Room object' unless room.is_a?(Tinder::Room)
      @room        = room
      @name        = options[:name] || 'bot'
      @sleep       = options[:sleep] || 1
      @config      = options[:config]
      @continue    = true
      @message_ids = [] # ids of message already processed
      
      load_data
    end
    
    def listen!
      trap("INT") do
        log "Stoping ..."
        @continue = false
        @room.leave
      end
      
      log "Starting the bot, CTRL+C to stop ..."
      @room.join
      @room.speak "ohaie! I'm back!"
      process while @continue
    end
    
    def process
      messages = fetch_messages
      messages.reject! { |m| @message_ids.include?(m[:id])  }
      process_commands(messages)
      notify_listeners(messages)
      @message_ids += messages.map { |m| m[:id] }
      write_data
      sleep @sleep
    rescue Timeout::Error
      log "Timeout while listening: #{$!}, rejoining room ..."
      @room.join(true)
    rescue Exception
      log "Error while listening: #{$!}"
      log $@
    end
    
    def process_commands(messages);
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
        log message[:person] + ": " + message[:message]
        message
      end
    end
    
    def data_file
      ROOT + "/data/#{name}.yml"
    end
    
    def load_data
      FileUtils.mkdir_p File.dirname(data_file)
      FileUtils.touch data_file
      @data = YAML.load_file(data_file) || {}
    end
    
    def write_data
      File.open(data_file, "w") { |file| YAML.dump(@data, file) }
    end
    
    def log(message)
      puts message
    end
  end
end