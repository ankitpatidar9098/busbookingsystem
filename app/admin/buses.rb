ActiveAdmin.register Bus do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :starting_city, :destination_city, :departure_time, :bustype, :pickup, :drop, :ticket_id, :arrival_time, :name, :number, :price, :seats
  #
  # or
  #
  permit_params do
    permitted = [:starting_city, :destination_city, :departure_time, :bustype, :pickup, :drop, :ticket_id, :arrival_time, :name, :number, :price, :seats]
    permitted << :other if params[:action] == 'create' 
    permitted
  end
  def index
  @buses = Bus.all.paginate(page: params[:page], per_page: 10)
  end

  
end
