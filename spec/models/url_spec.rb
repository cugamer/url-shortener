require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
    it { should validate_presence_of :full_url }
  end

  describe 'shortened URL' do
    before do
      allow(SecureRandom).to receive(:hex) { '12345' }
    end

    it 'will not allow creation when non-unique' do
      Url.create(full_url: 'urlone@gmail.com')
      expect { Url.create!(full_url: 'urltwo@gmail.com') }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
