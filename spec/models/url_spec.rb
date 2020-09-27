# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :full_url }

    describe 'short URL validation' do
      let(:url) { Url.new(full_url: 'www.test.com') }
      before do
        expect(url).to receive(:create_short_url).and_return(create_method_return)
      end

      context 'with blank short URL' do
        let(:create_method_return) { '' }
        
        it 'should fail validation' do
          expect { url.save! }.to raise_error ActiveRecord::RecordInvalid
        end
      end

      context 'with good short URL' do
        let(:create_method_return) { '1234567' }
        
        it 'should fail validation' do
          expect(url.save).to eq true
        end
      end
    end
  end

  # describe 'shortened URL' do
  #   before do
  #     allow(SecureRandom).to receive(:hex).and_return('12345')
  #   end

  #   it 'will not allow creation when non-unique' do
  #     described_class.create(full_url: 'urlone@gmail.com')
  #     expect { described_class.create!(full_url: 'urltwo@gmail.com') }
  #       .to raise_error(ActiveRecord::RecordInvalid)
  #   end
  # end
end
