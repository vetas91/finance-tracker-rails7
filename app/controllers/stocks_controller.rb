class StocksController < ApplicationController
  skip_after_action :verify_same_origin_request

  def search
    @stock = nil
    if params[:stock]
      if params[:stock][:ticker]
        ticker = params[:stock][:ticker]
        @stock = Stock.new_lookup(ticker)
        respond_to do |format|
          format.js { render partial: 'stocks/search_stock' }
        end
      else
        flash[:alert] = 'Please enter the ticker'
        render :edit, status: :unprocessable_entity
      end
    end
  end
end