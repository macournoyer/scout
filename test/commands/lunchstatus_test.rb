require File.dirname(__FILE__) + '/../test_helper'

class LunchstatusTest < Test::Unit::TestCase
  def setup
    @room = Tinder::Room.new(stub, 1, 'Test room')
    @bot = Scout::Bot.new(@room)
    @command = Scout::Commands::Lunchstatus.new("ma", @bot, "lunchstatus", [])
  end
  
  def test_display_places
    @command.stubs(:args).returns([])
    @command.expects(:paste)
    @command.expects(:places_message)
    @command.expects(:statuses_message)
    @command.process
  end

  def test_suggest_place
    @command.stubs(:args).returns(%w(+ home))
    @command.process
    assert_equal %w(home), @command.places
  end

  def test_update_status
    @command.stubs(:args).returns(["I has"])
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