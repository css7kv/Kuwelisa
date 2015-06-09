module RidesHelper

	def send_text_message(ride, num)
		# 0 = User Creates an Account (current_user)
		# 1 = Ride Sign Up (current_user and driver)
		# 2 = Ride Edit/ Ride Destroy (all ride.users)

  #Real Credentials
      account_sid = 'AC818b91aaf3aa4883ebd967c1ce05b4f8'
      auth_token = '635c887a39e2db3fffb74f31806d54d2'
      from_number = "+14086414548"
      
  # Test Credentials
  # account_sid = 'ACec40d0700dbd21edb9714b8b6ee492d6'
  # auth_token = '9924fa846b8eff1d94faee71ac69eb5f'
  # from_number = "+15005550006"
  # Developer number +15005550006
  # Emergency code SjBcxP8IdNqX//QdKvr8+Ma6o/DSWQU6m0nprKfT
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
    to: current_user.phone,
    body: "You have successfully signed up for a ride from #{ride.startloc} to #{ride.finishloc} on #{ride.datetime}. Your driver's number is #{driver.phone}."
  )

    message = @client.messages.create(
    from: from_number,
    to: driver.phone,
    body: "#{current_user.firstname} has signed up for your trip from #{ride.startloc} on #{ride.datetime}. Their number is #{current_user.phone}."
  )
  # elsif num == 0
  # 	message = @client.messages.create(
  #   from: from_number,
  #   to: current_user.phone,
  #   body: 'You have successfully created an account for Kuwelisa!'
  # )
  elsif num == 2
    ride.users.each do |passenger|
      if passenger.id != driver.id 
      message = @client.messages.create(
      from: from_number,
      to: passenger.phone,
      body: "Your ride on the #{datetime} has been changed. It is now from #{ride.startloc} to #{ride.finishloc} on #{ride.datetime}. Please go online if you would like more details."
    )
     end
    end
	end

  redirect_to rides_path
end
end
