require File.dirname(__FILE__) + '/../test_helper'

class CoffeeStatusTest < Test::Unit::TestCase
  def setup
    @room = Tinder::Room.new(stub, 1, 'Test room')
    @bot = Scout::Bot.new(@room)
    @command = Scout::Commands::CoffeeStatus.new("ma", @bot, "coffeestatus", [])
  end
  
  def test_update_status
    @command.stubs(:args).returns(["ya plz"])
    @command.process
    assert_not_nil @command.statuses["ma"]
  end

  def test_clear
    test_update_status
    
    @command.stubs(:args).returns(%w(clear))
    @command.process
    assert_equal Hash.new, @command.statuses
  end
end