class BusesController < ApplicationController
  def index
    @buses = Bus.paginate(page: params[:page])
  end

  def new
    @bus = Bus.new
  end

  def create
    @bus = Bus.new(bus_params)
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
    redirect_to root_path
  end


  private

  def bus_params
    params.require(:bus).permit(:name, :number, :company, :price, :seats, :route_id, :starting_city, :destination_city, :departure_time)
  end
end