require "rails_helper"

RSpec.describe SearchStatisticsService do
  let(:user)  { create(:user) }
  let(:rules) { { make: "BMW", model: "X5" } }

  describe "#call" do
    context "when search does not exist" do
      it "creates a new search statistic record" do
        service = described_class.new(
          user: user,
          rules: rules,
          total_quantity: 5
        )

        result = service.call

        expect(result).to be_persisted
        expect(result.user).to eq(user)
        expect(result.rules).to eq(rules.stringify_keys)
        expect(result.requests_quantity).to eq(1)
        expect(result.total_quantity).to eq(5)
      end
    end

    context "when search already exists" do
      let!(:existing_search) do
        create(:search,
               user: user,
               rules: rules,
               requests_quantity: 2,
               total_quantity: 3)
      end

      it "increments requests_quantity and updates total_quantity" do
        service = described_class.new(
          user: user,
          rules: rules,
          total_quantity: 10
        )

        result = service.call

        expect(result.id).to eq(existing_search.id)
        expect(result.requests_quantity).to eq(3)
        expect(result.total_quantity).to eq(10)
      end
    end

    context "when save fails" do
      it "logs error and returns nil" do
        allow_any_instance_of(Search).to receive(:save!)
          .and_raise(ActiveRecord::RecordInvalid.new(Search.new))

        service = described_class.new(
          user: user,
          rules: rules,
          total_quantity: 5
        )

        expect(service.call).to be_nil
      end
    end
  end
end
