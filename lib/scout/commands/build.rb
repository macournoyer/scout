require "feed_tools"

module Scout
  module Commands
    class Build < Scout::Command
      trigger :build
      help    "Show build status"
      
      def process
        project("quantumleap-cc", "quantumleap")
        project("pony-cc", "pony")
        project("reception-cc", "reception")
        project("jobcaster-cc", "jobcaster")
        project("backstage-cc", "backstage")
        project("backstage-cc", "hamster")
        project("pony-cc", "lolshare")
      end
      
      def project(subdomain, project_name)
        speak("[#{project_name}] " + build_status(subdomain, project_name) + " -- " + project_url(subdomain, project_name))
      end
      
      def project_url(subdomain, project_name)
        "http://#{subdomain}.office.standoutjobs.com:3333/builds/#{project_name}"
      end
      
      def build_status(subdomain, project_name)
        item = FeedTools::Feed.open(project_url(subdomain, project_name) + "?format=rss").items.first
        item.title
      rescue
        "SERVER DOWN"
      end
    end
  end
end
