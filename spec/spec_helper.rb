require File.join(File.dirname(__FILE__), '..', 'quickcharge.rb')

require 'rack/test'
require 'rspec'
require 'sinatra'
require 'webmock/rspec'

set :environment, :test