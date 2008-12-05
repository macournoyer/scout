require "cgi"

module Scout
  module Commands
    class Ask < Scout::Command
      trigger :how
      trigger :what
      trigger :when
      trigger :which
      trigger :who
      trigger :why
      
      help    "Ask a stupid question"
      
      def process
        speak "http://LetMeGoogleThatForYou.com/?q=" + CGI.escape(([command] + args).join(' '))
      end
    end
  end
end