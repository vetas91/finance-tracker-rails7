class PagesController < ApplicationController
  def show
    if params[:page] === nil
      render template: "pages/home"
    else
      render template: "pages/#{params[:page]}"
    end
  end
end