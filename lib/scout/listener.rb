module Scout
  class Listener
    include Processable
    
    attr_reader :from, :bot, :message
    
    LISTENERS = []
    
    class << self
      attr_reader :matchers
      
      def reacts_to(matcher)
        @matchers ||= []
        
        if String === matcher
          matcher = /(^|\s)#{matcher}(\s|$)/i
        end
        
        @matchers << matcher
        
        LISTENERS << self unless LISTENERS.include?(self)
      end
      
      def notify(message, bot)
        # Do not reply to itself
        return [] if message[:person] == bot.name || message[:message].match(/^@?#{bot.name}:\s/)
        
        LISTENERS.map do |listener|
          if listener.matchers.any? { |matcher| matcher.match(message[:message]) }
            listener.new(message[:person], bot, message[:message])
          end
        end.compact
      end
    end
    
    def initialize(from, bot, message)
      @from = from
      @bot = bot
      @message = message
    end
  end
end