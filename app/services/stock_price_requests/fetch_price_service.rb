# frozen_string_literal: true
require 'net/http'

module StockPriceRequests
  class FetchPriceService
    def initialize(stock_symbol)
      @stock_symbol = stock_symbol
    end

    def call
      api_key = ENV.fetch('DOSE_OF_STOCKS_ALPHAVANTAGE_API_KEY')
      uri = URI(
        'https://www.alphavantage.co/query?' \
        "function=GLOBAL_QUOTE&symbol=#{@stock_symbol}&apikey=#{api_key}"
      )

      response = nil

      Net::HTTP.start(uri.host, uri.port,
        :use_ssl => uri.scheme == 'https') do |http|
        request = Net::HTTP::Get.new uri

        response = http.request(request)
      end

      global_quote = JSON.parse(response.body)['Global Quote']

      return if global_quote.blank?

      global_quote['05. price']
    end
  end
end
