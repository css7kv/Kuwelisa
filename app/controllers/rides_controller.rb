class RidesController < ApplicationController
  def index
  	@rides = Ride.all
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

  private
  	def ride_params
  		params.require(:ride).permit( :startloc, :finishloc, :price, :driverid, :datetime, :duration, :driverid)
  		
  	end


end
