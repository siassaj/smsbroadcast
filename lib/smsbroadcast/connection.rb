require 'faraday'

class Smsbroadcast::Connection

  def initialize
    @conn = Faraday.new(url: Smsbroadcast.configuration.url) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end
end
