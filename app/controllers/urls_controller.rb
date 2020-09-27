# frozen_string_literal: true

class UrlsController < ApplicationController
  def create
    url = Url.find_or_create_by!(url_params)
    render json: url
  rescue StandardError => e
    render json: { error: e }, status: :bad_request
  end

  def show
    redirect_to "//#{Url.find_by(short_url: params[:id]).full_url}"
  end

  private

  def url_params
    params.permit(:full_url)
  end
end
