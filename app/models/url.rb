class Url < ApplicationRecord
  validates :full_url, :short_url, presence: true, uniqueness: true

  before_validation do
    short = SecureRandom.hex(4)
    while Url.where(short_url: short).exists?
      short = SecureRandom.hex(4)
    end
    
    self.short_url = short
  end
end
