require "rails_helper"

RSpec.describe CarSearch, type: :service do
  subject(:service) { described_class.new(scope, params).call }

  let(:scope) { Car.all }
  let(:params) { {} }

  describe "#call" do
    context "when no filters are applied" do
      let!(:car1) { create(:car) }
      let!(:car2) { create(:car) }

      it "returns all cars sorted by default" do
        expect(service).to match_array([ car1, car2 ])
      end
    end

    context "when filtering by make" do
      let!(:bmw)  { create(:car, make: "BMW") }
      let!(:audi) { create(:car, make: "Audi") }

      let(:params) { { make: "BMW" } }

      it "returns only cars with given make" do
        expect(service).to contain_exactly(bmw)
      end
    end

    context "when filtering by model" do
      let!(:xfive) { create(:car, model: "XFive") }
      let!(:audi)  { create(:car, model: "Audi") }

      let(:params) { { model: "XFive" } }

      it "returns only cars with given model" do
        expect(service).to contain_exactly(xfive)
      end
    end


    context "when filtering by year range" do
      let!(:old_car) { create(:car, year: 2010) }
      let!(:new_car) { create(:car, year: 2020) }

      let(:params) { { year_from: 2015 } }

      it "returns cars newer than year_from" do
        expect(service).to contain_exactly(new_car)
      end
    end

    context "when filtering by price range" do
      let!(:cheap)  { create(:car, price: 5_000) }
      let!(:expensive) { create(:car, price: 20_000) }

      let(:params) { { price_to: 10_000 } }

      it "returns cars cheaper than price_to" do
        expect(service).to contain_exactly(cheap)
      end
    end

    context "when filtering by odometer range" do
      let!(:low_mileage)  { create(:car, odometer: 20_000) }
      let!(:high_mileage) { create(:car, odometer: 150_000) }

      let(:params) { { odometer_to: 50_000 } }

      it "returns cars with lower mileage" do
        expect(service).to contain_exactly(low_mileage)
      end
    end

    context "when sorting by price ascending" do
      let!(:cheap)  { create(:car, price: 5_000) }
      let!(:expensive) { create(:car, price: 20_000) }

      let(:params) { { sort: "price", direction: "asc" } }

      it "sorts cars from low to high price" do
        expect(service.first).to eq(cheap)
      end
    end

    context "when sorting by price descending" do
      let!(:cheap)  { create(:car, price: 5_000) }
      let!(:expensive) { create(:car, price: 20_000) }

      let(:params) { { sort: "price", direction: "desc" } }

      it "sorts cars from high to low price" do
        expect(service.first).to eq(expensive)
      end
    end

    context "when sort param is invalid" do
      let!(:car1) { create(:car, date_added: 1.day.ago) }
      let!(:car2) { create(:car, date_added: Date.today) }

      let(:params) { { sort: "invalid" } }

      it "uses default sort" do
        expect(service.first).to eq(car2)
      end
    end

    context "when direction param is invalid" do
      let!(:car1) { create(:car, price: 10_000) }
      let!(:car2) { create(:car, price: 20_000) }

      let(:params) { { sort: "price", direction: "invalid" } }

      it "uses default direction (desc)" do
        expect(service.first).to eq(car2)
      end
    end

    context "when multiple filters are combined" do
      let!(:bmw_old) { create(:car, make: "BMW", year: 2010) }
      let!(:bmw_new) { create(:car, make: "BMW", year: 2022) }
      let!(:audi_new) { create(:car, make: "Audi", year: 2022) }

      let(:params) { { make: "BMW", year_from: 2020 } }

      it "returns correctly filtered cars" do
        expect(service).to contain_exactly(bmw_new)
      end
    end

    context "when params are blank strings" do
      let!(:car1) { create(:car) }
      let!(:car2) { create(:car) }

      let(:params) { { make: "" } }

      it "ignores blank filters" do
        expect(service.count).to eq(2)
      end
    end
  end
end
