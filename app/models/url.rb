class Url < ApplicationRecord
  validates :long_url, :short_url, presence: true
  validates :long_url, url: true
  validates_uniqueness_of :short_url, :long_url, case_sensitive: true

  before_validation :set_short_url
  after_create :fetch_title

  scope :most_views, -> { order("views DESC").limit(100) }

  def increment_view_count
    update_attributes(views: self.views + 1)
  end

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
    SecureRandom.base64(6).gsub("/","_").gsub(/=+$/,"")
  end

  def fetch_title
    TitleFetcherJob.perform_now(self) unless self.title.present?
  end
end
