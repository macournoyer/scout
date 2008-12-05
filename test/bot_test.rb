require File.dirname(__FILE__) + '/test_helper'

class BotTest < Test::Unit::TestCase
  def setup
    @campfire = stub
    @campfire.stubs(:get).with('room/1')
    @campfire.stubs(:verify_response)
    @campfire.stubs(:post)
    
    @room = Tinder::Room.new @campfire, 1, 'Test room'
    @bot = Scout::Bot.new @room
  end
  
  def test_initialize
    assert_not_nil @bot
  end
  
  def test_fetch_messages
    room_returns(message(:person => 'marc', :message => 'hi'))

    message = @bot.fetch_messages.first
    assert_equal 'marc', message[:person]
    assert_equal 'hi', message[:message]
  end
  
  def test_process_commands
    message = message(:person => 'marc', :message => '@bot say hi')
    command = mock(:process! => true)
    
    Scout::Command.expects(:parse).once.with(message, @bot).returns(command)
    
    @bot.process_commands([message])
  end
  
  def test_has_data_file
    assert_match "/data/bot.yml", @bot.data_file
  end

  def test_load_data_file
    assert_kind_of Hash, @bot.data
  end
  
  def test_write_data_after_process
    room_returns # nothing
    @bot.expects(:write_data).once
    @bot.process
  end
  
  private
    def room_returns(*msgs)
      @room.stubs(:listen).returns(msgs)
    end
    
    def message(options)
      options
    end
end
