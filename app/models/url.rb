class Url < ApplicationRecord
  validates :full_url, :short_url, presence: true, uniqueness: true

  before_validation do
    self.short_url = create_short_url
  end

  private

  def create_short_url
    short = SecureRandom.hex(4)
    attempts = 0
    while Url.where(short_url: short).exists? && attempts < 10
      short = SecureRandom.hex(4)
      attempts += 1
    end
    short
  end
end
