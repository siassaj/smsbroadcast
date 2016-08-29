require 'smsbroadcast/too_many_recipients_error'
require 'smsbroadcast/sms_response'

module Smsbroadcast
  class Sms < Connection

    attr_reader :to, :message, :ref, :from, :maxsplit, :delay

    def initialize(to:, message:, ref:, from: nil, maxsplit: nil, delay: nil)
      super()
      @to       =       to
      @message  =  message
      @ref      =      ref
      @from     =     from || Smsbroadcast.configuration.from
      @maxsplit = maxsplit || Smsbroadcast.configuration.maxsplit
      @delay    =    delay || Smsbroadcast.configuration.delay
    end

    def deliver
      if @to.respond_to?(:each) && @to.count > 1000
        raise TooManyRecipientsError, "Can only deliver in blocks of 1000 recipients"
      end

      to = @to.respond_to?(:each) ? @to.join(",") : @to

      resp = @conn.post("/api-adv.php") do |req|
        req.body = {to:       to,
                    message:  @message,
                    ref:      @ref,
                    from:     @from,
                    maxsplit: @maxsplit,
                    delay:    @delay,
                    username: Smsbroadcast.configuration.username,
                    password: Smsbroadcast.configuration.password}
      end

      SmsResponse.new resp.body
    end
  end
end
