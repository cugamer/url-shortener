# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Urls', type: :request do
  describe 'GET /create' do
    it 'returns http success' do
      get '/url/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/url/show'
      expect(response).to have_http_status(:success)
    end
  end
end
