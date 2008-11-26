require File.dirname(__FILE__) + '/test_helper'

class CommandTest < Test::Unit::TestCase
  def setup
    @room = Tinder::Room.new stub, 1, 'Test room'
    @bot = Scout::Bot.new @room
  end
  
  def test_tokenize
    assert_equal ['marc', 'say', %w(hi)], Scout::Command.tokenize!({:person => 'marc', :message => '@bot say hi'}, @bot)
    assert_equal ['marc', 'say', %w(hi)], Scout::Command.tokenize!({:person => 'marc', :message => 'bot: say hi'}, @bot)
    assert_equal ['marc', 'say', %w(hi)], Scout::Command.tokenize!({:person => 'marc', :message => '@bot: say hi'}, @bot)
    assert_equal ['marc', 'say', %w(hi there)], Scout::Command.tokenize!({:person => 'marc', :message => '@bot say hi there'}, @bot)
    assert_equal nil, Scout::Command.tokenize!({:person => 'marc', :message => 'wtf'}, @bot)
    assert_equal ['marc', 'yo', []], Scout::Command.tokenize!({:person => 'marc', :message => '@bot yo'}, @bot)
    assert_equal ['marc', 'vote', ['+1']], Scout::Command.tokenize!({:person => 'marc', :message => '@bot vote +1'}, @bot)
  end
  
  def test_create_correct_command_class
    command = Scout::Command.parse({:person => 'marc', :message => '@bot say hi'}, @bot)
    assert_kind_of Scout::Commands::Say, command
  end
  
  def test_invalid_command_instanciate_invalid_command_class
    command = Scout::Command.parse({:person => 'marc', :message => '@bot somethingwonrt'}, @bot)
    assert_kind_of Scout::Commands::Invalid, command
  end
  
  def test_help_command
    @room.expects(:paste).with do |text|
      assert_match /help/, text
      assert_match /say/, text
      assert_no_match /invalid/, text
      true
    end
    Scout::Commands::Help.new(nil, @bot, nil, nil).process
  end
end
