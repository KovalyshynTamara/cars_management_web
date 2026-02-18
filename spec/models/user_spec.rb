# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:searches).dependent(:destroy) }
  end

  describe "validations" do
    subject(:user) { create(:user) }

    # Devise :validatable
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  describe "dependent destroy" do
    it "destroys associated searches when user is destroyed" do
      user = create(:user)
      create(:search, user: user)

      expect { user.destroy }.to change(Search, :count).by(-1)
    end
  end
end
