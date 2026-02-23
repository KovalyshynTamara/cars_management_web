class CarsController < ApplicationController
  include Pagy::Backend

  ITEMS_PER_PAGE = 10

  before_action :authenticate_user!, except: %i[index show]
  before_action :set_car, only: %i[show edit update destroy]
  before_action :authorize_admin!, only: %i[new create edit update destroy]

  def index
    cars = CarSearch.new(Car.all, params).call
    @pagy, @cars = pagy(cars, items: ITEMS_PER_PAGE)
  end

  def show; end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      redirect_to @car, notice: t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @car.update(car_params)
      redirect_to @car, notice: t(".success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @car.destroy
      redirect_to cars_path, notice: t(".success")
    else
      redirect_to @car, alert: t(".failure")
    end
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:make, :model, :year, :odometer, :price, :description)
  end
end
