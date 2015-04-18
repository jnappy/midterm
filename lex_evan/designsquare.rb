require 'pry'
require_relative 'lib/designfirm'
require_relative 'lib/user'
require 'behance'

client = Behance::Client.new(access_token: "MB3es1sTQJ9GOByAJBY0kA5mfvkRVwaE")

users = []
design_firms = []

# creating first user and design firms #

test_user = User.new
users << test_user

firm = DesignFirm.new('CarbonTheory','CarbonTheory.com','897-987-0909','hello@CarbonTheory.com','22 somewhere st New York, NY 10021',23)
design_firms << firm

firm = DesignFirm.new('Chen Design Associates','chendesign.com','323-334-3422','chendesign.com','632 Commercial Street, San Francisco, CA 94111',14)
design_firms << firm


# Starting the program #

puts "Welcome to Design Square."
puts "A curated design network."

user_action = ""

until user_action == "e"
  puts "What would you like to do? Add a new (D)esign firm, Add a new (U)ser, or (V)iew all design firms?"
  puts "Type (E)xit to close the program."
  user_action = gets.strip.downcase
  until user_action == "d" || user_action == "u" || user_action == "v" || user_action == "e"
    puts "Hmm. That's not a valid option. You can (A)dd a new design firm, (J)oin as a new user, or (V)iew all design firms?"
    user_action = gets.strip
  end

  if user_action == "d"
    puts "Yay! Let's get that design firm added into the directory."
    firm = DesignFirm.new('name','website','phone','email','address','staff_size')

    puts "What is the design firm's name?"
    firm.name = gets.strip

    puts "What is this design firm's website address?"
    firm.website = gets.strip.downcase

    puts "What is this firm's phone number?"
    firm.phone = gets.strip

    puts "What is this firm's email address?"
    firm.email = gets.strip.downcase

    puts "What is this firm's physical address?"
    firm.address = gets.strip

    puts "What is this firm's staff size?"
    firm.staff_size = gets.strip.to_i

    puts "Awesome! You've added a new design firm on Design Square!"

    design_firms << firm

    puts "Here's this design firm's info:"
    puts ""
    puts "Name: #{firm.name}"
    puts "Joined: #{firm.joined}"
    puts "Website: #{firm.website}"
    puts "Phone Number: #{firm.phone}"
    puts "Email Address: #{firm.email}"
    puts "Physical Address: #{firm.address}"
    puts "Staff Size: #{firm.staff_size}"

    puts "Would you like to see a list of design firms? (Y) or (N)?"
    show_firms = gets.strip.downcase

    if show_firms == "y"
      design_firms.each { |firm| 
        puts ""
        puts "Name: #{firm.name}"
        puts "Joined: #{firm.joined}"
        puts "Website: #{firm.website}"
        puts "Phone Number: #{firm.phone}"
        puts "Email Address: #{firm.email}"
        puts "Physical Address: #{firm.address}"
        puts "Staff Size: #{firm.staff_size}"
        puts ""
      }
    end


  elsif user_action == "u"
    puts "Great! Lets add a new user."
    user = User.new

    puts "What is this user's first name?"
    user.fname = gets.strip

    puts "What is this user's last name?"
    user.lname = gets.strip

    puts "What is this user's email address?"
    user.email = gets.strip

    puts "What is this user's current job title?"
    user.title = gets.strip

    puts "How many years of job experience does this user have? (Please enter a number)"
    user.experience = gets.strip.to_i

    puts "Does the user have a behance account from which to import projects?  (Y) or (N)?"
    has_behance = gets.strip.downcase

    if has_behance == "y"
    puts "What is this user's behance username?"
    user.behance_username = gets.strip
    end

    behance_projects = client.user_projects(user.behance_username)

    user.project_covers = behance_projects.map { |project| "< img src = '#{project['covers']['404']}' >" }

    puts "Awesome! You've created a new user on Design Square!"

    users << user

    puts "Here's this user's info:"
    puts ""
    puts "Name: #{user.full_name}"
    puts "Email: #{user.email}"
    puts "Joined: #{user.joined}"
    puts "Title: #{user.title}"
    puts "Experience: #{user.experience}"
    puts "Project Images:"
    user.project_covers.each { |cover|
          puts "#{cover}"
          puts "----------------------"
    } 
    puts ""

    puts "Would you like to see a list of users? (Y) or (N)?"
    show_users = gets.strip.downcase

    if show_users == "y"
      users.each { |user| 
        puts ""
        puts "Name: #{user.full_name}"
        puts "Admin: #{user.admin}"
        puts "Joined: #{user.joined}"
        puts "Job Email: #{user.email}"
        puts "Job Title: #{user.title}"
        puts "Years of experience: #{user.experience}"
        puts "Project Images:"
        user.project_covers.each { |cover|
          puts "#{cover}"
          puts "----------------------"
        }
        puts ""
      }
    end

  elsif user_action == "v"
      design_firms.each { |firm| 
        puts ""
        puts "Name: #{firm.name}"
        puts "Joined: #{firm.joined}"
        puts "Website: #{firm.website}"
        puts "Phone Number: #{firm.phone}"
        puts "Email Address: #{firm.email}"
        puts "Physical Address: #{firm.address}"
        puts "Staff Size: #{firm.staff_size}"
        puts ""
      }
  end
end
