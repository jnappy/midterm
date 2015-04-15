require 'twilio-ruby'
require 'json'

# put your own credentials here - from twilio.com/user/account
account_sid = 'AC9ec3b0b2517ad11675b3d034514b947c'
auth_token = 'e9b6a8b6d9adc6f71736ef9cad353118'
 
# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new account_sid, auth_token

puts "Please enter a person's name"
name = gets.strip

puts "Please enter a phone number"
number = gets.strip

puts "Now calling #{name} at #{number}..."

@call = @client.account.calls.create(
  :from => '2315447075',   # From your Twilio number
  :to => number,     # To any number
  # Fetch instructions from this URL when the call connects
  :url => 'http://twimlbin.com/external/9e253dfb4edd9d44'
)
