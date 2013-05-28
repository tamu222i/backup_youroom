#!/usr/bin/env ruby
require 'yaml'
require 'pp'
require 'oauth'
require 'json'

$KCODE = 'utf8'
class String
  def is_binary_data?
    false
  end
end

#$:.unshift File.dirname(__FILE__) 
conf = YAML.load_file(File.dirname(__FILE__) + '/../conf/conf.yml')
pp conf

consumer = OAuth::Consumer.new(
  conf['consumer_key'],
  conf['consumer_secret'],
  :site => 'https://www.youroom.in'
)
pp consumer

access_token = consumer.get_access_token(
  nil, {}, {
    'x_auth_mode' => "client_auth",
    'x_auth_username' => conf['email'],
    'x_auth_password' => conf['password'],
  }
)
pp access_token
page = 0
File.unlink(conf['dump']) if File.exist?(conf['dump'])
begin
  page += 1
  res = access_token.get("https://www.youroom.in/r/#{conf['group_param']}/?format=json&page=#{page}")
  entries = JSON.parse(res.body)
  #pp entries
  entries.each do |entry| 
    id = entry['entry']['id']
    res = access_token.get("https://www.youroom.in/r/#{conf['group_param']}/entries/#{id}?format=json&page=#{page}")
    children = JSON.parse(res.body)
    pp children
    s = PP.pp(children, '')
    File.open(conf['dump'], "ab") {|f| f.write s}
  end
end while entries.count != 0
