FactoryBot.define do
  factory :url do
    long_url { Faker::Internet.url }
    short_url { SecureRandom.base64(8).gsub("/","_").gsub(/=+$/,"") }
    views { 0 }
  end
end