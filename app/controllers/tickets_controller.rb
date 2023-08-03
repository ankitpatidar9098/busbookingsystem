require 'prawn'

class TicketsController < ApplicationController
  authorize_resource

  def index
    @bus = Bus.find(params[:bus_id])
    @tickets = @bus.tickets
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def all_bookings
    @tickets = Ticket.all.order("id DESC")
    #@buses = Bus.all.order("id DESC")
  end

  def new
    @bus = Bus.find_by(id: params[:bus_id])
    @schedule = Schedule.find_by(bus_id: @bus.id)
    if current_user
      @ticket = Ticket.new
    else
      flash[:notice] = "Please sign up or sign in to book a ticket"
      redirect_to new_user_session_path
    end
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.user = current_user
    @ticket.status = :Pending
    if @ticket.save
      flash.now[:success] = "ticket save Successfully"
      redirect_to root_path
    else
      render "new"
    end
  end
  def print
  require 'prawn'

  @ticket = Ticket.find(params[:id])

  # Create a new PDF document
  pdf = Prawn::Document.new

  # Add content to the PDF
  pdf.text "Welcome to #{@ticket.bus.name}"
  pdf.move_down 10

  # Show the ticket status based on conditions
  if @ticket.Confirmed?
    pdf.text "Confirmed Ticket", size: 18, color: "00AA00"
  elsif @ticket.Rejected?
    pdf.text "Ticket Not Confirmed", size: 18, color: "FF0000"
  elsif @ticket.Cancelled?
    pdf.text "Cancelled", size: 18, color: "FF0000"
  else
    pdf.text "Ticket Not Confirmed yet - Status pending, please wait...", size: 18, color: "FF0000"
  end
  pdf.move_down 20

  # Add ticket information to the PDF
  pdf.text "Ticket Information", size: 20, style: :bold
  pdf.move_down 10

     pdf.text "Ticket ID: #{@ticket.id}"
     pdf.text "Bus ID: #{@ticket.bus_id}"
     pdf.text " Bus Route: #{@ticket.route.from} to #{@ticket.route.to}"
     pdf.text " Passenger Name: #{@ticket.name}"
     pdf.text "Passenger Age: #{@ticket.age}"
     pdf.text "Bus Far: #{@ticket.price}"
     pdf.text "Pickup Point: #{@ticket.bus.pickup}"
     pdf.text "Drop Point: #{@ticket.bus.drop}"
     pdf.text "Journey Date: #{@ticket.date}"
     pdf.text "Bus Departure Time: #{@ticket.bus.departure_time.strftime("%H:%M")}"
     pdf.text "Bus Arrival Time: #{@ticket.bus.arrival_time.strftime("%H:%M")}"
     pdf.text "Ticket Created At: #{@ticket.created_at}"
     pdf.text "Ticket Updated At: #{@ticket.updated_at}"
     pdf.text "Ticket Status: #{@ticket.status}"



    # ["Bus ID:", @ticket.bus_id],
    # ["Bus Route:", "#{@ticket.route.from} to #{@ticket.route.to}"],
    # ["Passenger Name:", ],
    # ["Passenger Age:", @ticket.age],
    # ["Passenger Sex:", @ticket.sex],
    # ["Bus Fare:", @ticket.price],
    # ["Pickup Point:", @ticket.bus.pickup],
    # ["Drop Point:", @ticket.bus.drop],
    # ["Journey Date:", @ticket.date],
    # ["Bus Departure Time:", @ticket.bus.departure_time.strftime("%H:%M")],
    # ["Bus Arrival Time:", @ticket.bus.arrival_time.strftime("%H:%M")],
    # ["Ticket Created At:", @ticket.created_at],
    # ["Ticket Updated At:", @ticket.updated_at],
    # ["Ticket Status:", @ticket.status]
  

  
  # Add cancel reasons if the ticket is cancelled
  if @ticket.Cancelled?
    pdf.move_down 10
    pdf.text "Cancel Reasons:", size: 16, style: :bold
    pdf.move_down 5
    pdf.text @ticket.cancel_reason
  end

  # Add footer with current date and time
  pdf.move_down 20
  time = Time.now.to_s
  time = DateTime.parse(time).strftime("%d/%m/%Y  %H:%M")
  pdf.text "Generated on: #{time}", align: :center

  # Save or send the PDF as a response to the user's browser
  send_data pdf.render, filename: "ticket.pdf", type: "application/pdf"
end


 def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update(ticket_params)
      flash[:alert] = "detaills updated"
      redirect_to root_path
    else
      render "edit"
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    flash[:alert] = "Ticket deleted"
    redirect_to request.referrer
  end

  def approve_ticket
    @ticket = Ticket.find(params[:ticket_id])
    if @ticket.status != "Confirmed" && @ticket.update(status: :Confirmed)
      bus = Bus.find(@ticket.bus.id)
      bus.seats -= 1
      bus.save
      flash[:alert] = "Ticket has been approved."
      redirect_to request.referrer
      TicketMailer.send_email(@ticket).deliver_now
    else
      redirect_to request.referrer, notice: "Ticket already Confirmed"
    end
  end

  def reject_ticket
    @ticket = Ticket.find(params[:ticket_id])
    if @ticket.status != "Rejected" && @ticket.update(status: :Rejected)
      bus = @ticket.bus
      bus.seats += 1
      bus.save
      flash[:alert] = "Ticket rejected successfully"
      redirect_to request.referrer
      TicketMailer.send_email(@ticket).deliver_now
    else
      redirect_to request.referrer, notice: "Ticket already rejected"
    end
  end

  def cancel_ticket
    @ticket = Ticket.find(params[:ticket_id])
    if @ticket.status != "Cancelled"
      if request.post?
        cancel_reason = params[:cancel_reason]
        @ticket.update(status: "Cancelled", cancel_reason: cancel_reason)
        bus = @ticket.bus
        bus.seats += 1
        bus.save
        redirect_to my_tickets_path, notice: "Ticket was successfully cancelled."
        TicketMailer.send_email(@ticket).deliver_now
      else
        render "tickets/cancel_ticket_form"
      end
    else
      redirect_to request.referrer, notice: "Ticket already cancelled."
    end
  end

  def cancelled_tickets
    @cancelled_tickets = Ticket.where(status: "Cancelled")
  end

  def send_email
    @ticket = Ticket.find(params[:id])
    TicketMailer.send_email(@ticket).deliver_now
  end

  private

  def ticket_params
    params.require(:ticket).permit(:name, :age, :sex, :bus_id, :route_id, :price, :departure_time, :arrival_time, :date)
  end
end
