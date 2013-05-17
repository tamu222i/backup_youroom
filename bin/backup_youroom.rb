#!/usr/bin/env ruby
require 'yaml'
require 'pp'

conf = YAML.load_file(File.dirname(__FILE__) + '/../conf/conf.yml')
pp conf
