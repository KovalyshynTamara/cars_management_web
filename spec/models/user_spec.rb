# frozen_string_literal: true

RSpec.describe User, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:searches).dependent(:destroy) }
  end

  describe "validations" do
    subject(:user) { create(:user) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end
end
