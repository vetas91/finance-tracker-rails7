class StocksController < ApplicationController

  def search
    # binding.break
    if params[:stock] && params[:stock][:js] == "true"
      if params[:stock][:ticker]
        ticker = params[:stock][:ticker]
        @stock = Stock.new_lookup(ticker)
        # if @stock != nil
          respond_to do |format|
            format.js { render partial: 'stocks/search_stock' }
          end
        # else
        #   flash[:alert] = 'Invalid ticker'
        #   redirect_to my_portfolio_path
        # end
      else
        flash[:alert] = 'Please enter the ticker'
        redirect_to my_portfolio_path
      end
    else
      render json: nil
    end
  end
end