class SearchesController < ApplicationController
  before_action :authenticate_user!, only: :index

  def new
  end

  def create
    search = CarSearch.new(Car.all, search_params)
    cars   = search.call

    if user_signed_in?
      stats = SearchStatisticsService.new(
        user: current_user,
        rules: search_params.to_h,
        total_quantity: cars.count
      ).call

      unless stats
        flash.now[:alert] = "Could not save search statistics."
        @cars = cars
        return render :new, status: :unprocessable_entity
      end
    end

    redirect_to cars_path(search_params)
  end


  def index
    @searches = current_user.searches
  end

  def destroy
    @search = current_user.searches.find(params[:id])
    if @search.destroy
      redirect_to searches_path, notice: t(".success")
    else
      redirect_to searches_path, alert: t(".failure")
    end
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
