require File.dirname(__FILE__) + '/test_helper'

class TestBot < Test::Unit::TestCase
  def setup
    @campfire = stub
    @campfire.stubs(:get).with('room/1')
    @campfire.stubs(:verify_response)
    
    @room = Tinder::Room.new @campfire, 1, 'Test room'
    @bot = Scout::Bot.new @room
  end
  
  def test_initialize
    assert_not_nil @bot
  end
  
  def test_listen
    room_returns(message(:person => 'marc', :message => 'hi'))

    command = @bot.fetch_commands.first
    assert_equal 'marc', command.message[:person]
    assert_equal 'hi', command.message[:message]
  end
  
  def test_parse_command
    room_returns(message(:person => 'marc', :message => '@bot say hi'))
    
    command = @bot.fetch_commands.first
    assert_equal 'say', command.command
    assert_equal 'hi', command.args[0]
  end
  
  private
    def room_returns(*msgs)
      @room.stubs(:post).returns(stub(:body => msgs.collect { |m| m.body } * "\r\n"))
    end
    
    def message(options)
      stub(:body => 'chat.transcript.queueMessage(' +
        '<tr class=\"text_message message user_237935\" id=\"message_38554689\" ' +
        %Q(style=\"display: none\">\n  <td class=\"person\"><span>#{options[:person]}</span></td>\n) +
        %Q[<td class=\"body\"><div>#{options[:message]}</div></td>\n</tr>\n", 38554689);] + "\r\n" + 
        'chat.poller.lastCacheID = 101480814;')
    end
end
