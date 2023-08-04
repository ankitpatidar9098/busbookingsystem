require 'rails_helper'

RSpec.describe BusesController, type: :controller do
  describe "GET #index" do
    it "returns a successful response" do
      route = Route.create(from: "City A", to: "City B")
      get :index, params: { route_id: route.id }
      expect(response).to have_http_status(200)
    end
  end
  describe "GET #all_buses" do
    it "returns a successful response" do
      get :all_buses
      expect(response).to have_http_status(302)
    end
  end
  # describe "GET #new" do
  #   it "assigns a new Bus to @bus" do
  #     get :new
  #     expect(assigns(:bus)).to be_a_new(Bus)
  #   end

    # it "renders the new template" do 
    #   get :new
    #   expect(response).to render_template(:new)
    # end
   describe "POST #create" do
    context "with valid parameters" do
      it "creates a new bus" do
      	post :create, params: { bus: { starting_city: "City A", destination_city: "City B", name: "Bus X", number: "123", bustype: "AC", price: 500, seats: 30, departure_time: "10:00", arrival_time: "14:00" } }
        expect(response).to have_http_status(201)

      end

      it "redirects to root_path" do
        post :create, params: { bus: { starting_city: "City A", destination_city: "City B", name: "Bus X", number: "123", bustype: "AC", price: 500, seats: 30, departure_time: "10:00", arrival_time: "14:00" } }
        expect(response).to redirect_to(root_path)
      end
    end
 end 
end