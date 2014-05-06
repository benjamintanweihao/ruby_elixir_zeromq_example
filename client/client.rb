#!/usr/bin/env ruby

require 'rubygems'
require 'ffi-rzmq'
require 'json'

context = ZMQ::Context.new

puts "Connecting to server..."
requester = context.socket(ZMQ::REQ)
requester.connect("tcp://localhost:5555")

0.upto(99999999999999) do |num|
  puts "Sending request: #{num}..."
  requester.send_string(num.to_s)

  reply = ''
  requester.recv_string(reply)

  begin
    puts "Received reply : #{JSON.parse(reply)["result"]}"
  rescue
  end
end