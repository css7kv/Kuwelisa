class RidesController < ApplicationController
  def index
  	@rides = Ride.where.not(pcount: 0).where(:datetime => Time.zone.now..1.year.from_now).order(:datetime)
    @count = "1"

  end


  def new
  	@ride = Ride.new
  end


  def create 
  	@ride = Ride.create(ride_params)
  	@ride.driverid = current_user.id
  	@ride.users << current_user
  	if @ride.save 
  		redirect_to @ride
  	else
  		render :new
  	end
  end


  def edit
  	@ride = Ride.find(params[:id])
  end

  def update
  	@ride = Ride.find(params[:id])
  	if @ride.save
  		redirect_to @ride
  	else
  		render :edit
  	end
  end


  def show 
  	@ride = Ride.find(params[:id])
  end

  def destroy
  	@ride = Ride.find(params[:id])
  	@ride.destroy

  	redirect_to rides_path
  end 

  def signup
      @ride = Ride.find(params[:id])
      @ride.users << current_user
      @count = "1"
      @ride.pcount = @ride.pcount - @count.to_i

      @ride.save
      
      redirect_to twilio_send_text_message_path
      
  end

  private
  	def ride_params
  		params.require(:ride).permit( :startloc, :finishloc, :price, :driverid, :datetime, :duration, :driverid, :pcount)
  		
  	end


end
