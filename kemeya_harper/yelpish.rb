require 'rest-client'
require 'pry'
require 'yelp'

CONSUMER_KEY = 'bGt0YnXpbR6tZ49e_V0v3g'
CONSUMER_SECRET = 'FTxmDbE9A1H2_NLugooFUp_wZkM'
TOKEN = 'trF3wLEbs_92aRC9vvAD25SatRdm6Gjf'
TOKEN_SECRET = 'BBXoYYOmQM0IAZQ6FWjPTrRvFK4'
KEY = 'zAtuP2gXZZ7h7x1VjSTHiA'

# setting up the yelp client with my api keys.
# source: github.com/Yelp/yelp-ruby#basic-usage
Yelp.client.configure do |config|
  config.consumer_key = CONSUMER_KEY
  config.consumer_secret = CONSUMER_SECRET
  config.token = TOKEN
  config.token_secret = TOKEN_SECRET
end
# I want to pull out specific data from yelp based on a location.
# User inputs their address, web app will display number of matching
# results within a 0.25 miles and 0.5 miles.

# create class to store the user's location
class User_Location
# define getter and setter for user's address
  def user_address=(address_input)
    @user_address = address_input
  end
  def user_address
    @user_address
  end
# define getter and setter for user's city
  def user_city=(city_input)
    @user_city = city_input
  end
  def user_city
    @user_city
  end
# define getter and setter for user's state
  def user_state=(state_input)
    @user_state = state_input
  end
  def user_state
    @user_state
  end
# define getter and setter for user's zip
  def user_zip=(zip_input)
    @user_zip = zip_input
  end
  def user_zip
    @user_zip
  end
# define method that uses string interpolation to join together
# all componants and returns user's location
  def user_location
    "#{user_address}, #{user_city}, #{user_state} #{user_zip}"
  end  
end
# instantiate the user_location object and store it in a variable
start_point = User_Location.new
# get data from user
puts 'Welcome'
puts
puts 'Enter your address (building number and street name):'
start_point.user_address = gets.strip
puts
puts 'and your city:'
start_point.user_city = gets.strip
puts
puts 'your state (abbreviated):'
start_point.user_state = gets.strip
puts
puts 'and last, your zip:'
start_point.user_zip = gets.strip
puts
# 
# =================================================================
# define yelp api filter for cafes within 0.25 miles (400 meters)
# =================================================================
cafes_filter_400 = {
  term: 'cafe',
  radius_filter: 400 }
# search yelp with 400 filter defined above and store in a variable
response_400 = Yelp.client.search(start_point.user_location, cafes_filter_400).raw_data
# reduce raw data response from filtered yelp search and store into a variable 
response_400_total = response_400['total']
# display results to user
puts 'Here is what is within 0.25 miles of your address:'
puts "Cafes: #{response_400_total}"
puts
# 
# =================================================================
# define yelp api filter for cafes within 0.50 miles (800 meters)
# =================================================================
cafes_filter_800 = {
  term: 'cafe',
  radius_filter: 800 }
# search yelp with 800 filter defined above and store in a variable
response_800 = Yelp.client.search(start_point.user_location, cafes_filter_800).raw_data
# reduce raw data response from filtered yelp search and store into a variable 
response_800_total = response_800['total']
# display results to user
puts 'Here is what is within 0.5 miles of your address:'
puts "Cafes: #{response_800_total}"
puts
# 
# =================================================================
# define yelp api filter for cafes within 0.75 miles (1200 meters)
# =================================================================
cafes_filter_1200 = {
  term: 'cafe',
  radius_filter: 1200 }
# search yelp with 1200 filter defined above and store in a variable
response_1200 = Yelp.client.search(start_point.user_location, cafes_filter_1200).raw_data
# reduce raw data response from filtered yelp search and store into a variable 
response_1200_total = response_1200['total']
puts 'Here is what is within 0.75 miles of your address:'
puts "Cafes: #{response_1200_total}"
puts
# 
# =================================================================
# define yelp api filter for cafes within 1.00 mile (1600 meters)
# =================================================================
cafes_filter_1600 = {
  term: 'cafe',
  radius_filter: 1600 }
# search yelp with 1600 filter defined above and store in a variable
response_1600 = Yelp.client.search(start_point.user_location, cafes_filter_1600).raw_data
# reduce raw data response from filtered yelp search and store into a variable 
response_1600_total = response_1600['total']
puts 'Here is what is within 1 mile of your address:'
puts "Cafes: #{response_1600_total}"
puts




