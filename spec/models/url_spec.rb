# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :full_url }

    describe 'short URL validation' do
      let(:url) { described_class.new(full_url: 'www.test.com') }

      before do
        allow(url).to receive(:create_short_url).and_return(create_method_return)
      end

      context 'with blank short URL' do
        let(:create_method_return) { '' }

        it 'fails validation' do
          expect { url.save! }.to raise_error ActiveRecord::RecordInvalid
        end
      end

      context 'with good short URL' do
        let(:create_method_return) { '1234567' }

        it 'fails validation' do
          expect(url.save).to eq true
        end
      end
    end
  end
end
