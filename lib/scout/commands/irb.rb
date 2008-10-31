require "open-uri"
require "cgi"

module Scout
  module Commands
    class Irb < Scout::Command
      trigger :irb
      help    "Eval some ruby"
      
      def process
        if args.first == "reset"
          @@session = reset_session
        else
          @@session ||= reset_session
          cmd = args.join(" ")
          cmd.gsub!("\u0026quot;", '"')
          paste try_eval(cmd, @@session)
        end
      end
      
      def try_eval(s, session_id)
        open("http://tryruby.hobix.com/irb?cmd=#{CGI.escape(s)}", "Cookie" => "_session_id=#{session_id}").read
      end
      
      def reset_session
        s = try_eval("!INIT!IRB!", nil)
        speak "IRB session started"
        s
      end
    end
  end
end