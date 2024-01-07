class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock != nil
        render 'users/my_portfolio'
      else
        flash[:alert] = 'Invalid ticker'
        redirect_to my_portfolio_path
      end
    else
      flash[:alert] = 'Please enter the ticker'
      redirect_to my_portfolio_path
    end
  end
end