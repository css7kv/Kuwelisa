module RidesHelper

  def durationcalculator(wp1lat, wp1long, wp2lat, wp2long)
    response = Typhoeus.get("http://api.tiles.mapbox.com/v4/directions/mapbox.driving/#{wp1long.to_s},#{wp1lat.to_s};#{wp2long.to_s},#{wp2lat.to_s}.json?access_token=pk.eyJ1Ijoib3NjYXJ3MyIsImEiOiIxZDQ4MTE2NGFlYWJjNTY1ODZhMWJmNzQ3OTUwZGE4MyJ9.tlyn20Cn-ecT9wwQYHtpzA")
    results = JSON.parse(response.body)
    if(results["routes"]!=nil)
    seconds = results["routes"][0]["duration"]
    Time.at(seconds).utc.strftime("%H:%M:%S")
    else
    0
    end  
  end

  def waypointcalculator(wp1lat, wp1long, wp2lat, wp2long)
    response = Typhoeus.get("http://api.tiles.mapbox.com/v4/directions/mapbox.driving/#{wp1long.to_s},#{wp1lat.to_s};#{wp2long.to_s},#{wp2lat.to_s}.json?access_token=pk.eyJ1Ijoib3NjYXJ3MyIsImEiOiIxZDQ4MTE2NGFlYWJjNTY1ODZhMWJmNzQ3OTUwZGE4MyJ9.tlyn20Cn-ecT9wwQYHtpzA")
    results = JSON.parse(response.body)
    if(results["routes"]!=nil)
    waypoints = results["routes"][0]["geometry"]["coordinates"]
    else
    []  
    end
  end

  def actualnum(num)
    num = num.split(//)
    num.shift
    num.unshift "+27"
    num = num.join
  end
	def send_text_message(ride, num)
		
		# 1 = Ride Sign Up (current_user and driver)
		# 2 = Ride Edit (all ride.users)
		# 3 = Ride Destroy (passengers)
    # 4 = User Unsignedup (driver)

  #Real Credentials
      # account_sid = 'AC818b91aaf3aa4883ebd967c1ce05b4f8'
      # auth_token = '635c887a39e2db3fffb74f31806d54d2'
      # from_number = "+14086414548"
      
  # Test Credentials
  account_sid = 'ACec40d0700dbd21edb9714b8b6ee492d6'
  auth_token = '9924fa846b8eff1d94faee71ac69eb5f'
  from_number = "+15005550006"
  
  # Developer number +15005550006
  # Emergency code SjBcxP8IdNqX//QdKvr8+Ma6o/DSWQU6m0nprKfT
  #0715796472
  #0606094336
		driver = User.find(ride.driverid)


  # set up a client to talk to the Twilio REST API
  #@client = Twilio::REST::Client.new account_sid, auth_token

  # alternatively, you can preconfigure the client like so
  Twilio.configure do |config|
    config.account_sid = account_sid
    config.auth_token = auth_token
  end

  # and then you can create a new client without parameters
  @client = Twilio::REST::Client.new



  if num == 1
  message = @client.messages.create(
    from: from_number,
    to: actualnum(current_user.phone),
    body: "You have successfully signed up for a ride from #{ride.startloc} to #{ride.finishloc} on #{ride.datetime.strftime("%B %d, %Y")} at #{ride.datetime.strftime("%I:%M %p")}. Your driver's number is #{driver.phone}."
  )

    message = @client.messages.create(
    from: from_number,
    to: actualnum(driver.phone),
    body: "#{current_user.firstname} has signed up for your trip from #{ride.startloc} on #{ride.datetime.strftime("%B %d, %Y")} at #{ride.datetime.strftime("%I:%M %p")}. Their number is #{current_user.phone}."
  )
  elsif num == 4
   	 message = @client.messages.create(
     from: from_number,
     to: actualnum(driver.phone),
     body: "#{current_user.firstname} is no longer signd up for your trip from #{ride.startloc} on #{ride.datetime.strftime("%B %d, %Y")} at #{ride.datetime.strftime("%I:%M %p")}."
   )
  elsif num == 2
    ride.users.each do |passenger|
      if passenger.id != driver.id 
      message = @client.messages.create(
      from: from_number,
      to: actualnum(passenger.phone),
      body: "Your ride on the #{ride.datetime} has been changed. It is now from #{ride.startloc} to #{ride.finishloc} on #{ride.datetime.strftime("%B %d, %Y")} at #{ride.datetime.strftime("%I:%M %p")}. Please go online if you would like more details."
    )
     end
    end
elsif num == 3
	ride.users.each do |passenger|
      if passenger.id != driver.id 
      message = @client.messages.create(
      from: from_number,
      to: actualnum(passenger.phone),
      body: "Your ride on #{ride.datetime.strftime("%B %d, %Y")} at #{ride.datetime.strftime("%I:%M %p")} from #{ride.startloc} to #{ride.finishloc} has been cancelled."
    )
  end
end
end

  
end



end
