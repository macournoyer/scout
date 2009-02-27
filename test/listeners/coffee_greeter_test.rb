require File.dirname(__FILE__) + '/../test_helper'

class CoffeeGreeterTest < Test::Unit::TestCase
  def setup
    @room = Tinder::Room.new stub, 1, 'Test room'
    @bot = Scout::Bot.new @room
  end
  
  def test_should_not_trigger_when_bot_joins
    assert Scout::Listener.notify( {:person => 'bot', :message => 'has entered the room'}, @bot).empty?
  end
  
  def test_should_trigger_when_alexandra_joins
    coffee_greeter_listener = Scout::Listener.notify( {:person => 'Alexandra', :message => 'has entered the room'}, @bot).first
    assert_kind_of Scout::Listeners::CoffeeGreeter, coffee_greeter_listener
    Time.stubs(:now).returns(Time.utc(2009,"apr",11,9,15,1))
    coffee_greeter_listener.expects(:run_command).with("coffeestatus", ["clear"])
    coffee_greeter_listener.expects(:run_command).with("coffeestatus")
    coffee_greeter_listener.process
  end
end