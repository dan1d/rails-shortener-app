class Url < ApplicationRecord
  validates :long_url, :short_url, presence: true
  validates :long_url, url: true
  validates_uniqueness_of :short_url, case_sensitive: true
  before_save :set_short_url

  private

  def set_short_url
    return if self.short_url.present?
    short_url = generate_short_url
    while self.short_url.nil?
      if Url.where(short_url: short_url).exists?
        short_url = generate_short_url
        next
      end
      self.short_url = short_url
    end
  end

  def generate_short_url
    SecureRandom.base64(8).gsub("/","_").gsub(/=+$/,"")
  end
end
