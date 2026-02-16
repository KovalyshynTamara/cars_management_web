class SearchesController < ApplicationController
  before_action :authenticate_user!, only: :index

  def new
  end

  def create
    search = CarSearch.new(Car.all, search_params)
    cars = search.call

    if user_signed_in?
      SearchStatisticsService.new(current_user, search_params.to_h, cars.count).call
    end

    redirect_to cars_path(search_params)
  end

  def index
    @searches = current_user.searches
  end

  def destroy
    @search = current_user.searches.find(params[:id])
    @search.destroy
    redirect_to searches_path, notice: "Search deleted successfully."
  end

  private

  def search_params
    params.permit(
      :make,
      :model,
      :year_from,
      :year_to,
      :price_from,
      :price_to,
      :sort,
      :direction
    )
  end
end
