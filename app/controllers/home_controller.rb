class HomeController < ApplicationController
#    def index
#     @routes ='Booking'
#   end
#   def home
#   end
  
#   def bus
#    #@buses = Bus.all
#   end
# end
   
   	def index
         @routes = Route.paginate(page: params[:page])
    end
 end   