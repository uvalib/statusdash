#
# localize the request mechanism
#
require 'httparty'

class Requester
   include HTTParty
   default_timeout 5
end