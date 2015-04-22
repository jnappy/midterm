require 'json'
require 'pry'
require 'rest-client'
require 'sinatra'



class Character
  def initialize(name, gender)
    @name = name
    @gender = gender
    @species = 'human'
  end

  # Define a getter and setter for normal read/write class attributes
  attr_accessor :name
  attr_accessor :gender
  attr_accessor :species
  attr_accessor :description
  attr_accessor :pronoun_subj
  attr_accessor :pronoun_obj
  attr_accessor :pronoun_pos
end



#  Solicit user input and make a Character based on the user

puts "What's your name?"
user_name = gets.strip
puts "Are you male or female?"
user_gender = gets.strip
puts "What is one word you would use to describe yourself?"
user_description = gets.strip

user = Character.new(user_name, user_gender)

# @TODO: Add description setting method on Character?
user.description = user_description
# @TODO: Add pronoun setting method on Character
user.gender == 'male' ? user.pronoun_subj = 'he' : user.pronoun_subj = 'she'
user.gender == 'male' ? user.pronoun_obj = 'him' : user.pronoun_obj = 'her'
user.gender == 'male' ? user.pronoun_pos = 'his' : user.pronoun_pos = 'her'

puts "Thanks, #{user.name}."

puts "Just a few more questions."
sleep 0.4

#  Make another Character based on the user's bff

puts
puts "What is your best friend's name?"
bff_name = gets.strip
puts "Is your best friend male or female?"
bff_gender = gets.strip
puts "What is the species of your best friend?"
bff_species = gets.strip
puts "What is one word you would use to describe your best friend?"
bff_description = gets.strip

bff = Character.new(bff_name, bff_gender)

# @TODO: Add species setting method on Character?
bff.species = bff_species
# @TODO: Add description setting method on Character?
bff.description = bff_description
# @TODO: Add pronoun setting method on Character
bff.gender == 'male' ? bff.pronoun_subj = 'he' : bff.pronoun_subj = 'she'
bff.gender == 'male' ? bff.pronoun_obj = 'him' : bff.pronoun_obj = 'her'
bff.gender == 'male' ? bff.pronoun_pos = 'his' : bff.pronoun_pos = 'her'

sleep 0.4
puts
puts "Lastly, what is one word that would describe your mood right now?"
mood = gets.strip


# Sinatra takes the stage!

get '/' do
  @user = user
  @bff = bff

  # @TODO: Class for giphy images!!!
  # @TODO: Error handling for non-200 response

  # Make a Giphy API call for the user image  
  url = "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=#{user.description}"
  response = JSON.parse(RestClient.get(url))
  @user_giphy = response['data']['image_original_url']

  # Make a Giphy API call for the mood image
  @mood = mood
  url = "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=#{mood}"
  response = JSON.parse(RestClient.get(url))
  @mood_giphy = response['data']['image_original_url']

  # Make a Giphy API call for the bff image
  url = "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=#{bff.description}"
  response = JSON.parse(RestClient.get(url))
  @bff_giphy = response['data']['image_original_url']

  # Make a Giphy API call for the bff species image
  url = "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=#{bff.species}"
  response = JSON.parse(RestClient.get(url))
  @bff_species_giphy = response['data']['image_original_url']

  # Make a Giphy API call for the happy image
  url = "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=happy"
  response = JSON.parse(RestClient.get(url))
  @happy_giphy = response['data']['image_original_url']

  # Make a Giphy API call for the sunset image
  url = "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=sunset"
  response = JSON.parse(RestClient.get(url))
  @sunset_giphy = response['data']['image_original_url']

  # Make a Giphy API call for the cat butt image
  url = "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=cat+butt"
  response = JSON.parse(RestClient.get(url))
  @cat_butt_giphy = response['data']['image_original_url']

  erb :index
end



# Punch it, Scotty

system "open http://localhost:4567/"