module Scout
  module Commands
    class Info < Scout::Command
      trigger :info
      trigger :info
      help    "display info"
      
      def process
        paste <<-EOS
version   #{Scout::VERSION::STRING}
bot name  #{bot.name}
root      #{Scout::ROOT}
command   #{Scout::CMD}
PID       #{Process.pid}
awesome   indeed
EOS
      end
    end
  end
end