require 'rails_helper'
# require 'validate_url/rspec_matcher'

RSpec.describe Url, type: :model do
  Sidekiq::Testing.disable! do
    describe "validations" do
      before { allow(subject).to receive(:fetch_title).and_return(true) }

      subject { create(:url) }
      it { is_expected.to validate_presence_of(:long_url) }
      it { is_expected.to validate_presence_of(:short_url) }
      it { is_expected.to validate_uniqueness_of(:short_url) }
      it { is_expected.to validate_url_of(:long_url) }
    end
  end

  Sidekiq::Testing.inline! do
    describe "#pull_title" do
      let(:title) { "Title Tag | 2019 SEO Best Practices - Moz" }
      let(:long_url) { "https://moz.com/learn/seo/title-tag" }
      subject { create(:url, long_url: long_url) }
      it "pulls the title from the page" do 
        expect(subject.title).to eq(title)
      end
    end
  end
end
