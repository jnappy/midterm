require 'pry'
require 'rest-client'
require 'json'
require_relative 'lib/congressppl'

puts
puts "This program will give you all the Congress people that are associated with a certain zipcode. Please go ahead and type in a zipcode:"
puts

user_zip = gets.strip

user_zip.to_i

if user_zip.size != 5
  puts "Please enter a five digit zip code. Run the Program again"
  exit
end


#if /^\d{5}$/ != user_zip
#puts "Please enter a five digit zip code"
#exit
#end 

url = "congress.api.sunlightfoundation.com/legislators/locate?zip=#{user_zip}&apikey=a88acef08fc24a5092ac6e71e5e7ccca"

response = RestClient.get(url)

parsed_response = JSON.parse(response)

posts = []

parsed_response['results'].each do |post|
  

  first_name = post['first_name']
  last_name = post['last_name']
  party = post['party']
  chamber = post['chamber']
  district = post['district']
  email = post['oc_email']
  
  post = Congressppl.new(first_name, last_name, party, chamber, district, email)
  #above, commented out "post = Congress.ppl

  #Apartment.new(apartment_number, apartment_square_feet, apartment_bedrooms, apartment_bathrooms)
  #post = {first_name: first_name, last_name: last_name, party: party, chamber: chamber, district: district, email: email}
  #bring back post = line, and it'll work. delete the instantiation of the class Congressppl. 


  posts << post

end
#binding.pry

puts
puts "Here are the Congressmen and Women from the zipcode #{user_zip.to_i}"
puts

#posts.each do |post|
 # puts post
#end
#Will put the congresspll with the ID, that's it

times_to_loop = posts.size
i = 0

while i < times_to_loop
    puts "#{i+1}"
    puts "First Name: #{posts[i].first_name}"
    puts "Last Name: #{posts[i].last_name}"
    puts "Party: #{posts[i].party}"
    puts "Chamber: #{posts[i].chamber}"
    puts "District: #{posts[i].district}"
    puts "Email: #{posts[i].email}"
    puts
    i += 1
end