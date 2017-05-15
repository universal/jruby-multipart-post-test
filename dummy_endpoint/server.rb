require 'bundler/setup'
require 'net/http/server'
require 'pp'

puts "Server starting - listening on port 3000"
Net::HTTP::Server.run(:port => 3000) do |request,stream|
  pp request

  [200, {'Content-Type' => 'text/plain'}, ['dummy - works']]
end