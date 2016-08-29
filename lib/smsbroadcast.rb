require "smsbroadcast/connection"
require "smsbroadcast/too_many_recipients_error"
require "smsbroadcast/sms"
require "smsbroadcast/version"
require "smsbroadcast/configurable"
require "smsbroadcast/configuration"


module Smsbroadcast
  extend Configurable

  configure do |config|
    config.url = "https://api.smsbroadcast.com.au/"
  end
end
