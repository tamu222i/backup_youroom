#!/usr/bin/env ruby
require 'yaml'
require 'pp'
require 'oauth'

conf = YAML.load_file(File.dirname(__FILE__) + '/../conf/conf.yml')
pp conf

consumer = OAuth::Consumer.new(
  conf['consumer_key'],
  conf['consumer_secret'],
  :site => 'https://www.youroom.in'
)
pp consumer

begin
  
rescue
  puts "Error: #{$!}"
end
