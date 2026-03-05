# frozen_string_literal: true

RSpec.describe "Searches", type: :request do
  let(:user) { create(:user) }

  describe "GET /new" do
    it "returns success" do
      get new_search_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    let(:params) do
      {
        make: "Toyota",
        price_from: 5000
      }
    end

    context "when not signed in" do
      it "redirects to cars path with params" do
        post searches_path, params: params
        expect(response).to redirect_to(cars_path(params))
      end
    end

    context "when signed in and statistics service succeeds" do
      before do
        sign_in user
        allow_any_instance_of(SearchStatisticsService)
          .to receive(:call)
          .and_return(true)
      end

      it "redirects to cars path" do
        post searches_path, params: params
        expect(response).to redirect_to(cars_path(params))
      end
    end

    context "when signed in and statistics service fails" do
      before do
        sign_in user
        allow_any_instance_of(SearchStatisticsService)
          .to receive(:call)
          .and_return(false)
      end

      it "renders new with unprocessable_entity" do
        post searches_path, params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /index" do
    context "when not authenticated" do
      it "redirects to login" do
        get searches_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when authenticated" do
      before { sign_in user }

      it "returns success" do
        get searches_path
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:search) { create(:search, user: user) }

    before { sign_in user }

    it "deletes search" do
      expect {
        delete search_path(search)
      }.to change(Search, :count).by(-1)

      expect(response).to redirect_to(searches_path(locale: I18n.locale))
    end
  end
end
