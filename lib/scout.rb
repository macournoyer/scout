$:.unshift File.dirname(__FILE__)

require 'rubygems'
require 'tinder'
require 'active_support'

require 'scout/version'
require 'scout/bot'
require 'scout/processable'
require 'scout/command'
require 'scout/listener'

Dir[File.dirname(__FILE__) + '/scout/{commands,listeners}/*.rb'].each(&method(:require))
