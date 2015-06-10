class RidesController < ApplicationController
  include RidesHelper
  def index
  	@rides = Ride.where.not(pcount: 0).where(:datetime => Time.zone.now..1.year.from_now).order(:datetime)
    

  end


  def new
  	@ride = Ride.new
  end


  def create 
  	@ride = Ride.create(ride_params)
  	@ride.driverid = current_user.id
  	@ride.users << current_user
  	if @ride.save 
      startloc = Location.create(:address => @ride.startloc)
      @ride.locations << startloc
      finishloc = Location.create(:address => @ride.finishloc)
      @ride.locations << finishloc
      @ride.save
      startloc.save
      finishloc.save
    
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
  	if @ride.update(ride_params)
      @ride.locations.destroy_all
      startloc = Location.create(:address => @ride.startloc)
      @ride.locations << startloc
      finishloc = Location.create(:address => @ride.finishloc)
      @ride.locations << finishloc
      @ride.save
      startloc.save
      finishloc.save
      send_text_message(@ride, 2)
      redirect_to @ride
  	else
  		render :edit
  	end
  end


  def show 
  	@ride = Ride.find(params[:id])
    @driver = User.find(@ride.driverid)

  end

  def destroy
  	@ride = Ride.find(params[:id])
    send_text_message(@ride, 3)
  	@ride.destroy
    redirect_to rides_path
  end 

  def signup
      @ride = Ride.find(params[:id])
      @ride.users << current_user
      count = params[:signup][:count]
      @ride.pcount = @ride.pcount - count.to_i
      @ride.save
  
      send_text_message(@ride, 1)
      redirect_to rides_path
      
  end

  



  private
  	def ride_params
  		params.require(:ride).permit( :startloc, :finishloc, :price, :driverid, :datetime, :duration, :driverid, :pcount)
  		
  	end


end
