require "smsbroadcast/connection"
require "smsbroadcast/too_many_recipients_error"
require "smsbroadcast/sms"
require "smsbroadcast/status"
require "smsbroadcast/version"
require "smsbroadcast/configurable"
require "smsbroadcast/configuration"

module Smsbroadcast
  extend Configurable
end

Smsbroadcast.configure do |config|
  config.url = "https://api.smsbroadcast.com.au/"
  config.from = "getFoodi"
  config.maxsplit = "1"
  config.delay = "0"
end
