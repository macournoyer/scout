module Scout
  module Commands
    class Update < Scout::Command
      trigger :update
      help    "update & restart the bot"
      
      def process
        speak "Updating code ..."
        paste `cd #{Scout::ROOT} && git pull`

        if $?.success?
          run_command :restart
        else
          speak "Failed to update code."
        end
      end
    end
  end
end