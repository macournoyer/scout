$:.unshift File.dirname(__FILE__)

require 'rubygems'
require 'tinder'
require 'active_support'
require 'scout/version'
require 'scout/bot'
require 'scout/command'

Dir[File.dirname(__FILE__) + '/scout/commands/*.rb'].each { |f| require "scout/commands/#{File.basename(f, '.rb')}" }