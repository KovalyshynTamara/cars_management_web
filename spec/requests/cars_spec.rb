# frozen_string_literal: true

RSpec.describe "Cars", type: :request do
  let(:admin) { create(:user, admin: true) }
  let(:user)  { create(:user, admin: false) }
  let!(:car)  { create(:car) }

  describe "GET /index" do
    it "returns http success" do
      get cars_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get car_path(car)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /new" do
    context "when not authenticated" do
      it "redirects to login" do
        get new_car_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when authenticated but not admin" do
      before { sign_in user }

      it "redirects to root" do
        get new_car_path
        expect(response).to redirect_to(root_path(locale: I18n.locale))
      end
    end

    context "when admin" do
      before { sign_in admin }

      it "returns success" do
        get new_car_path
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "POST /create" do
    let(:valid_params) do
      {
        car: attributes_for(:car)
      }
    end

    context "when admin" do
      before { sign_in admin }

      it "creates a car" do
        expect {
          post cars_path, params: valid_params
        }.to change(Car, :count).by(1)

        expect(response).to redirect_to(Car.last)
      end
    end

    context "when invalid" do
      before { sign_in admin }

      it "renders unprocessable_entity" do
        post cars_path, params: { car: { make: "" } }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "when admin" do
      before { sign_in admin }

      it "updates the car" do
        patch car_path(car), params: { car: { make: "Honda" } }

        expect(car.reload.make).to eq("Honda")
        expect(response).to redirect_to(car)
      end
    end

    context "when invalid" do
      before { sign_in admin }

      it "renders unprocessable_entity" do
        patch car_path(car), params: { car: { make: "" } }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    before { sign_in admin }

    it "deletes the car" do
      expect {
        delete car_path(car)
      }.to change(Car, :count).by(-1)

      expect(response).to redirect_to(cars_path(locale: I18n.locale))
    end
  end
end
