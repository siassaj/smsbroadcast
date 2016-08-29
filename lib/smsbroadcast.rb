require "smsbroadcast/sms"
require "smsbroadcast/status"
require "smsbroadcast/version"
require "smsbroadcast/configurable"

module Smsbroadcast
  extend Configurable
end

Smsbroadcast.configure do |config|
  config.url = "https://api.smsbroadcast.com.au/"
  config.from = "getFoodi"
  config.maxsplit = "1"
  config.delay = "0"
end
