require File.dirname(__FILE__) + '/../test_helper'

class UrlListenerTest < Test::Unit::TestCase
  def setup
    @room = Tinder::Room.new stub, 1, 'Test room'
    @bot = Scout::Bot.new @room
  end
  
  def test_notify_with_url
    assert_kind_of Scout::Listeners::UrlListener, 
                   Scout::Listener.notify( {:person => "unicorn", :message => "<a href=\"http://kottke.org/\">http://kottke.org/</a>"}, @bot).first
  end
  
  def test_notify_with_url_should_extract_page_title
    Scout::Listeners::UrlListener.any_instance.expects(:extract_page_title)
    Scout::Listener.notify( {:person => "unicorn", :message => "<a href=\"http://kottke.org/\">http://kottke.org/</a>"}, @bot).first.process
  end

  def test_notify_with_tweet_should_extract_content
    Scout::Listeners::UrlListener.any_instance.expects(:extract_tweet_content)
    Scout::Listener.notify( {:person => "unicorn", :message => "<a href=\"http://twitter.com/yukihiro_matz/status/1213839957\">http://twitter.com/yukihiro_matz/status/1213839957</a>"}, @bot).first.process
  end
  
end