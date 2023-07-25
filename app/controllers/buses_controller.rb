class BusesController < ApplicationController
  authorize_resource
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  def index
    @route = Route.find(params[:route_id])
    @buses = @route.buses.paginate(page: params[:page])
  end
  def show
    @bus = Bus.find(params[:id])
  end
  def new
    @bus = Bus.new
  end

  def create
    @bus = Bus.new(bus_params)
     dates = params[:bus][:dates]
    if dates.present?
      @bus.dates = dates.reject(&:empty?).map(&:strip).join(", ")
    else
      @bus.dates = []
    end

    if @bus.save
      flash[:success] = "Bus Added successfully"
      redirect_to root_path
    else
      render "new"
    end
  end

  def edit
    @bus = Bus.find(params[:id])
  end

  def update
    @bus = Bus.find(params[:id])
    if @bus.update(bus_params)
      flash[:success] = "Bus updated"
      redirect_to root_path
    else
      render "edit"
    end
  end
   def destroy
    Bus.find(params[:id]).destroy
    flash[:success] = "Bus deleted"
    redirect_to request.referrer
  end
     def search
    @from = params[:from]
    @to = params[:to]
    @buses = Bus.where(starting_city: @from, destination_city: @to)
  end

  private

  def bus_params
    params.require(:bus).permit(:name, :number, :company, :price, :seats, :route_id, :starting_city, :destination_city, :departure_time)
  end
  def logged_in_user
    unless user_signed_in?
      flash[:danger] = "Please sign up or sign in"
      redirect_to new_user_registration_path
    end
  end
end