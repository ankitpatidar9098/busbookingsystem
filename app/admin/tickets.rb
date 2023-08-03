ActiveAdmin.register Ticket do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :bus_id, :price, :name, :age, :sex, :status, :date, :cancel_reason, :arrival_time, :departure_time, :route_id
  #
  # or
  #
  permit_params do
    permitted = [:user_id, :bus_id, :price, :name, :age, :sex, :status, :date, :cancel_reason, :arrival_time, :departure_time, :route_id]
    permitted << :other if params[:action] == 'create'
  end
  
end
