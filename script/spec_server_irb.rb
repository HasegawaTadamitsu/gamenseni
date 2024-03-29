#!/usr/bin/env ruby

##
# script/spec_server_irb

require 'drb/drb'
require 'irb'

begin
  begin
    DRb.start_service("druby://localhost:0")
  rescue SocketError, Errno::EADDRNOTAVAIL
    DRb.start_service("druby://:0")
  end
  $spec_server = DRbObject.new_with_uri("druby://127.0.0.1:8989")
rescue DRb::DRbConnError
  err.puts "No DRb server is running. Running in local process instead ..."
end

def rspec(file)
  $spec_server.run(["--color", "--format", "s", file], STDERR, STDOUT)
end

puts <<DESC

Example:
  > rspec 'spec/models/user_spec.rb'

DESC

IRB.start
