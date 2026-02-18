# frozen_string_literal: true

require "rails_helper"

RSpec.describe Search, type: :model do
  subject(:search) { build(:search) }

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:rules) }
  end
end
