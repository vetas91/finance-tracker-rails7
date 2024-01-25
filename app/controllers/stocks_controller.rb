class StocksController < ApplicationController
  skip_after_action :verify_same_origin_request

  def search
    @stock = nil
    if params[:stock]
      if params[:stock][:ticker]
        ticker = params[:stock][:ticker]
        @stock = Stock.new_lookup(ticker)
        if @stock != nil
          respond_to do |format|
            format.js { render partial: 'stocks/search_stock' }
          end
        else
          respond_to do |format|
            flash.now[:alert] = 'Invalid ticker'
            format.js { render partial: 'stocks/search_stock' }
          end
        end
      else
        respond_to do |format|
          flash.now[:alert] = 'Please enter the ticker'
          format.js { render partial: 'stocks/search_stock' }
        end
      end
    end
  end
end