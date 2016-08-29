require "smsbroadcast/configuration"

module Smsbroadcast
  module Configurable
    attr_accessor :configuration

    def configure
      self.configuration = Configuration.new
      yield(self.configuration)
    end
  end
end
