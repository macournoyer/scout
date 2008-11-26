require "cgi"

module Scout
  module Commands
    class Ask < Scout::Command
      trigger :how
      trigger :what
      trigger :when
      trigger :which
      trigger :who
      help    "Ask a stupid question"
      
      def process
        speak "http://LetMeGoogleThatForYou.com/?q=" + CGI.escape(args.join(' '))
      end
    end
  end
end