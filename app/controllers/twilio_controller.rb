class TwilioController < ApplicationController
def index
end

def send_text_message


# Real Credentials
	account_sid = 'AC818b91aaf3aa4883ebd967c1ce05b4f8'
	auth_token = '635c887a39e2db3fffb74f31806d54d2'
	from_number = "+14086414548"

	# Test Credentials
	# account_sid = 'ACec40d0700dbd21edb9714b8b6ee492d6'
	# auth_token = '9924fa846b8eff1d94faee71ac69eb5f'
	# from_number = "+15005550006"
	# Developer number +15005550006
	# Emergency code SjBcxP8IdNqX//QdKvr8+Ma6o/DSWQU6m0nprKfT

	# set up a client to talk to the Twilio REST API
	#@client = Twilio::REST::Client.new account_sid, auth_token

	# alternatively, you can preconfigure the client like so
	Twilio.configure do |config|
	  config.account_sid = account_sid
	  config.auth_token = auth_token
	end

	# and then you can create a new client without parameters
	@client = Twilio::REST::Client.new

	message = @client.messages.create(
	  from: from_number,
	  to: '+27715169907',
	  body: 'You Have Signed Up!'
	)

	redirect_to rides_path
end
end
