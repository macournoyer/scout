module Scout
  module Commands
    class Vote < Scout::Command
      trigger :vote
      help    "Start a poll (start, +1|-1, stop)"
      
      def process
        case args.first
        when 'start'
          start
        when 'stop'
          stop
        else
          vote args.first
        end
      end
      
      def title
        args[1, args.size-1].join(' ')
      end
      
      def start
        @@for = 0
        @@against = 0
        @@voters = []
        @@title = title
        
        speak "Starting votes for #{@@title}"
        speak " @#{bot.name} vote +1 : to vote for"
        speak " @#{bot.name} vote -1 : to vote against"        
      end
      
      def stop
        speak "Vote finished for #{@@title}!"
        speak "#{@@for} votes for"
        speak "#{@@against} votes against"
      end
      
      def vote(verdict)
        if @@voters.include? from
          speak "#{from} you already voted on this one"
          return
        end
        
        case verdict
        when '+1'
          @@for += 1
          @@voters << from
        when '-1'
          @@against += 1
          @@voters << from
        else
          speak "Invalid vote #{verdict}, use +1 or -1"
        end
      end
    end
  end
end