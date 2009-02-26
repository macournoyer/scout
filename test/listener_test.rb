require File.dirname(__FILE__) + '/test_helper'

class ListenerTest < Test::Unit::TestCase
  def setup
    @room = Tinder::Room.new stub, 1, 'Test room'
    @bot = Scout::Bot.new @room
  end
  
  def test_notify_welcome
    assert_kind_of Scout::Listeners::Welcome, Scout::Listener.notify({:person => 'marc', :message => 'Bob has entered the room'}, @bot).last
  end
end
