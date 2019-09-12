class UrlController < ApplicationController

  def index
    @most_views = Url.most_views
    @url = Url.new
    @shorted_url = params[:short_url]
  end

  def create
    @url = Url.new(permitted_parameters)
    if @url.save
      flash[:success] = "Url shorted!"
      redirect_to root_path(short_url: @url.short_url)
    else
      flash.now[:error] = "Url cannot be shorted!"
      @most_views = Url.most_views
      render :index
    end
  end

  def redirect
    url = Url.find_by(short_url: params[:short_url])
    url.increment_view_count # if user clicks back on browser it adds a new view, I should check for headers maybe.
    redirect_to url.long_url
  end

  private

  def permitted_parameters
    params[:url].permit(:long_url)
  end
end
