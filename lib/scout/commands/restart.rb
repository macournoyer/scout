module Scout
  module Commands
    class Restart < Scout::Command
      trigger :restart
      help    "restart the bot"
      
      def process
        speak "Restarting ..."
        log "Restarting ..."
        exec Scout::CMD
      end
    end
  end
end