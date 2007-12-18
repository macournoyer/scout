# Publish build status in a Campfire room.
# Requires the tinder gem: sudo gem install tinder.
# 
# Adding the following lines to /path/to/builds/your_project/cruise_config.rb
#  <pre><code>
#    Project.configure do |project|
#      ...
#      project.campfire_notifier.account = 'mysubdomain'
#      project.campfire_notifier.username = 'bot@mydomain.com'
#      project.campfire_notifier.password = 'your_password'
#      project.campfire_notifier.room = 'Main room'
#      ...
#    end
#  </code></pre>
# Start the builder (./cruise build your_project)

require 'rubygems'
require 'tinder'

class CampfireNotifier
  attr_accessor :account, :username, :password, :room
  
  FIXED_MESSAGES = [
    "%s, you fixed %s, I love you!",
    "I think %s is the best hacker *EVER*, he fixed %s!",
    "%s fixed %s build like a champ! Congrats!",
    "Holy cow! %s fixed %s build again and again and again! *WOW!*"
  ]
  BROKEN_MESSAGES = [
    "%s broke %s build! Damn you!",
    "Holy crap! %s broke %s build... again!",
    "Why did you do this %s ? You broke %s build !",
    "No! %s broke %s"
  ]
  
  def initialize(project = nil)
    @account = ''
    @username = ''
    @password = ''
    @room = ''
  end
  
  def build_broken(build, previous_build)
    send_message build, BROKEN_MESSAGES
  end

  def build_fixed(build, previous_build)
    send_message build, FIXED_MESSAGES
  end  
    
  private
    def get_build_info(build)
      changeset = ChangesetLogParser.new.parse_log(build.changeset.split("\n"))
      author = changeset.last.committed_by
      [author, build.project.name]
    end
  
    def send_message(build, messages)
      campfire = Tinder::Campfire.new @account
      campfire.login @username, @password
      room = campfire.find_room_by_name @room
      
      message = messages[rand(messages.size)] % get_build_info(build)
      
      room.speak message
      room.speak build.url
    end
end

Project.plugin :campfire_notifier
