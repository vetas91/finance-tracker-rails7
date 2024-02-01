class UsersController < ApplicationController
  protect_from_forgery except: :index
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @tracked_friends = current_user.friends
  end

  def search
    @searched_users = nil
    if params[:user]
      if params[:user][:search]
        searchedValue = params[:user][:search]
        # binding.b
        @searched_users = User.search(searchedValue);
        @searched_users = current_user.except_current_user(@searched_users)
        if @searched_users != nil
          respond_to do |format|
            format.js { render partial: 'users/search_user' }
          end
        else
          respond_to do |format|
            flash.now[:alert] = 'Invalid name provided'
            format.js { render partial: 'users/search_user' }
          end
        end
      else
        respond_to do |format|
          flash.now[:alert] = 'Please enter the name'
          format.js { render partial: 'users/search_user' }
        end
      end
    end
  end


  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end
end
