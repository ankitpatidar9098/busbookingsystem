require 'rails_helper'


RSpec.describe RoutesController, type: :controller do
  describe "GET #new" do
    it "assigns a new Route to @route" do
      get :new
      expect(assigns(:route)).to be_a_new(Route)
    end

   
  end
   describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to have_http_status(200)
    end
  end
  describe "GET #show" do
    it "displays a particular route" do
      route = Route.create(from: "City A", to: "City B")
      get :show, params: { id: route.id }
      expect(response).to have_http_status(200)
    end
  end
  describe "GET #edit" do
    it "assigns the requested route to @route" do
      route = Route.create(from: "City A", to: "City B")
      get :edit, params: { id: route.id }
      expect(assigns(:route)).to eq(route)
    end
end

    describe "PUT #update" do
    context "with valid parameters" do
      it "updates the requested route" do
        route = Route.create(from: "City A", to: "City B")
        put :update, params: { id: route.id, route: { from: "City A", to: "City B" } }
        route.reload
        expect(route.from).to eq("City A")
        expect(route.to).to eq("City B")
      end

      it "redirects to root_path" do
        route = Route.create(from: "City A", to: "City B")
        put :update, params: { id: route.id, route: { from: "City X", to: "City Y" } }
        expect(response).to redirect_to(root_path)
      end
    end
    context "with invalid parameters" do
      it "does not update the route" do
        route = Route.create(from: "City A", to: "City B")
        put :update, params: { id: route.id, route: { from: "", to: "City Y" } }
        route.reload
        expect(route.from).to eq("City A")  
        expect(route.to).to eq("City B")
      end

      it "renders the edit template" do
        route = Route.create(from: "City A", to: "City B")
        put :update, params: { id: route.id, route: { from: "", to: "City B" } }
        expect(response).to have_http_status(302)
      end
    end
  end
end