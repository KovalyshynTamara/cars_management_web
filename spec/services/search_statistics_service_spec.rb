# frozen_string_literal: true

RSpec.describe SearchStatisticsService do
  subject(:service_call) { service.call }

  let(:user) { create(:user) }
  let(:rules) { { make: "BMW", model: "X5" } }
  let(:total_quantity) { 5 }

  let(:service) do
    described_class.new(
      user: user,
      rules: rules,
      total_quantity: total_quantity
    )
  end

  describe "#call" do
    context "when search does not exist" do
      it "creates a new record" do
        expect { service_call }.to change(Search, :count).by(1)
      end

      it "persists the result" do
        expect(service_call).to be_persisted
      end

      it "assigns the correct user" do
        expect(service_call.user).to eq(user)
      end

      it "stores stringified rules" do
        expect(service_call.rules).to eq(rules.stringify_keys)
      end

      it "sets requests_quantity to 1" do
        expect(service_call.requests_quantity).to eq(1)
      end

      it "sets total_quantity correctly" do
        expect(service_call.total_quantity).to eq(5)
      end
    end

    context "when search already exists" do
      let!(:existing_search) do
        create(
          :search,
          user: user,
          rules: rules,
          requests_quantity: 2,
          total_quantity: 3
        )
      end

      let(:total_quantity) { 10 }

      it "does not create a new record" do
        expect { service_call }.not_to change(Search, :count)
      end

      it "returns the existing record" do
        expect(service_call.id).to eq(existing_search.id)
      end

      it "increments requests_quantity" do
        expect(service_call.requests_quantity).to eq(3)
      end

      it "updates total_quantity" do
        expect(service_call.total_quantity).to eq(10)
      end
    end

    context "when save fails" do
      before do
        allow(Search).to receive(:new).and_call_original
        allow_any_instance_of(Search)
          .to receive(:save!)
          .and_raise(ActiveRecord::RecordInvalid.new(Search.new))
      end

      it "returns nil" do
        expect(service_call).to be_nil
      end
    end
  end
end
