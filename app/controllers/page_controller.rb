class PageController < ApplicationController
  def show
    render template: "pages/#{params[:page]}"
  end
end
