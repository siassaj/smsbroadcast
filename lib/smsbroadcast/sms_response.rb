module Smsbroadcast
  class SmsResponse

    attr_reader :status, :number, :ref, :message

    def initialize(response_string)
      @response_string = response_string
      parse_response
    end

    private

    def parse_response
      arry = @response_string.split(":")
      @status = arry.first.downcase.to_sym

      case @status
      when :ok
        @number  = arry[1]
        @ref     = arry[2]
      when :bad
        @number  = arry[1]
        @message = arry[2]
      when :error
        @message = arry[1]
      end
    end
  end
end
