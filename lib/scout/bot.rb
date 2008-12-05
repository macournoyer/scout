module Scout
  class InvalidRoom < StandardError; end
  
  class Bot
    attr_accessor :name, :room, :config, :data
    
    def initialize(room, options={})
      raise InvalidRoom, 'You need to supply a Tinder::Room object' unless room.is_a?(Tinder::Room)
      @room     = room
      @name     = options[:name] || 'bot'
      @sleep    = options[:sleep] || 1
      @config   = options[:config]
      @continue = true
      
      load_data
    end
    
    def listen!
      trap("INT") do
        puts "Stoping ..."
        @continue = false
        @room.leave
      end
      
      puts "Starting the bot, CTRL+C to stop ..."
      process while @continue
    end
    
    def process
      messages = fetch_messages
      process_commands(messages)
      notify_listeners(messages)
      write_data
      sleep @sleep
    rescue Exception
      puts "Error while listening: #{$!}"
      puts $@
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
    
    def data_file
      ROOT + "/data/#{name}.yml"
    end
    
    def load_data
      FileUtils.mkdir_p File.dirname(data_file)
      FileUtils.touch data_file
      @data = YAML.load_file(data_file)
    end
    
    def write_data
      File.open(data_file, "w") { |file| YAML.dump(@data, file) }
    end
  end
end