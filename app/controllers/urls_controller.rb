class UrlsController < ApplicationController
  def new

  end

  def create
    url = Url.create!(url_params)
    render json: url
  rescue => e
    render json: { error: e }, status: :bad_request
  end

  def show
    redirect_to "//#{Url.find_by_short_url(params[:id]).full_url}"
  end

  private

  def url_params
    params.permit(:full_url)
  end
end
