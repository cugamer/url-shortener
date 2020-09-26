# frozen_string_literal: true

class Url < ApplicationRecord
  validates :full_url, :short_url, presence: true

  before_validation do
    self.short_url = create_short_url
  end

  private

  def create_short_url
    short = SecureRandom.hex(4)
    attempts = 0
    while Url.exists?(short_url: short) && attempts < 10
      short = SecureRandom.hex(4)
      attempts += 1
    end
    short
  end
end
