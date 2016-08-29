require 'smsbroadcast/connection'

module Smsbroadcast
  class Status < Smsbroadcast::Connection

    attr_reader :status, :balance, :message

    def call
      resp = @conn.get "/api-adv.php" do |req|
        req.body = {action: "balance",
                    username: Smsbroadcast.configuration.username,
                    password: Smsbroadcast.configuration.password}
      end

      @response_string = resp.body

      parse_response
    end

    private

    def parse_response
      arry = @response_string.split(":")
      @status = arry.first.downcase.to_sym

      case @status
      when :ok
        @balance = arry[1]
      when :error
        @message = arry[1]
      end
    end
  end
end
