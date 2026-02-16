class CarsController < ApplicationController
  include Pagy::Backend

  before_action :set_car, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :authorize_admin!, only: %i[new create edit update destroy]


  def index
    cars = Car.all

    if params[:sorting].present?
      sort, direction = params[:sorting].split("_")
      params[:sort] = sort
      params[:direction] = direction
    end

    cars = CarSearch.new(cars, params).call

    @pagy, @cars = pagy(cars, items: 10)
  end



  def show; end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      redirect_to @car, notice: "Car was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @car.update(car_params)
      redirect_to @car, notice: "Car was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @car.destroy
    redirect_to cars_path, notice: "Car was successfully deleted."
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:make, :model, :year, :odometer, :price, :description)
  end

  def authorize_admin!
    redirect_to root_path, alert: "Access denied." unless current_user&.admin?
  end
end
