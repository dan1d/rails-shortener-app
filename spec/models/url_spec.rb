require 'rails_helper'
# require 'validate_url/rspec_matcher'

RSpec.describe Url, type: :model do
  describe "validations" do
    subject { create(:url) }
    it { is_expected.to validate_presence_of(:long_url) }
    it { is_expected.to validate_presence_of(:short_url) }
    it { is_expected.to validate_uniqueness_of(:short_url) }
    it { is_expected.to validate_url_of(:long_url) }
  end
end
