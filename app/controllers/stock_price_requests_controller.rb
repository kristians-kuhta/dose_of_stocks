# frozen_string_literal: true

class StockPriceRequestsController < ApplicationController
  def new
    @stock_symbol = params[:stock_symbol]
    @stock_price = params[:stock_price]
  end

  def create
    stock_symbol = params[:stock_symbol]
    stock_price = StockPriceRequests::FetchPriceService.new(stock_symbol).call

    if stock_price.present?
      redirect_to new_stock_price_request_path(
        stock_symbol: stock_symbol,
        stock_price: stock_price
      )
    else
      flash.now[:error] = 'No data for selected stock symbol'

      render :new
    end
  end
end
