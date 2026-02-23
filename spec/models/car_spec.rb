# frozen_string_literal: true

RSpec.describe Car, type: :model do
  subject(:car) { build(:car) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:make) }
    it { is_expected.to validate_presence_of(:model) }

    it { is_expected.to validate_length_of(:make).is_at_least(3).is_at_most(50) }
    it { is_expected.to validate_length_of(:model).is_at_least(3).is_at_most(50) }

    it { is_expected.to allow_value("Toyota").for(:make) }
    it { is_expected.not_to allow_value("To1ota").for(:make) }
    it { is_expected.not_to allow_value("To-yota").for(:make) }

    it { is_expected.to allow_value("Corolla").for(:model) }
    it { is_expected.not_to allow_value("C0rolla").for(:model) }

    it { is_expected.to validate_presence_of(:year) }

    it do
      is_expected.to validate_numericality_of(:year)
        .only_integer
        .is_greater_than_or_equal_to(1901)
    end

    it "is invalid if year is greater than current year" do
      car.year = Time.current.year + 1
      expect(car).not_to be_valid
    end

    it { is_expected.to validate_presence_of(:odometer) }

    it do
      is_expected.to validate_numericality_of(:odometer)
        .only_integer
        .is_greater_than_or_equal_to(0)
    end

    it { is_expected.to validate_presence_of(:price) }

    it do
      is_expected.to validate_numericality_of(:price)
        .only_integer
        .is_greater_than_or_equal_to(0)
    end

    it do
      is_expected.to validate_length_of(:description)
        .is_at_most(described_class::MAX_DESCRIPTION)
    end
  end

  describe "date_added default value" do
    it "sets date_added to current date by default" do
      car = described_class.new
      expect(car.date_added).to eq(Date.current)
    end
  end
end
