#!/usr/bin/ruby
# Commit hook to publish commits in Campfire room.
# Requires the tinder gem: sudo gem install tinder.
# 
# Put this in your /svn/repo/path/hooks/post-commit
# /usr/bin/ruby /var/lib/svn/project/hooks/campfire_post_commit_hook.rb "$1" "$2"

CAMPFIRE = {
  :subdomain => 'mysubdomain',
  :email     => 'admin@example.com',
  :password  => 'peanutketchup',
  :room      => 'Main Room'
}
CHANGESET_URL = 'http://trac.example.com/changeset/%s' # %s is the revision number
SVNLOOK       = '/usr/bin/svnlook'

require 'rubygems'
require 'tinder'

campfire = Tinder::Campfire.new CAMPFIRE[:subdomain]
campfire.login CAMPFIRE[:email], CAMPFIRE[:password]
room = campfire.find_room_by_name CAMPFIRE[:room]

if ARGV.size > 1
  revision = ARGV[1]
  path     = ARGV[0]
        
  author  = `#{SVNLOOK} author -r #{revision} #{path}`
  paths   = `#{SVNLOOK} changed -r #{revision} #{path}`
  log     = `#{SVNLOOK} log -r #{revision} #{path}`
  message = [log, paths].join.strip
  url     = "#{author} commited #{CHANGESET_URL}/#{revision}"
  
  room.speak url
  room.paste message
else
  room.speak ARGV[0]
end

room.leave
campfire.logout