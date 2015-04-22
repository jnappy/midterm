class User
  def initialize
    @fname = "Johnny"
    @lname = "Designer"
    @email = "hello@domain.com"
    @title = "Senior Director of Fun"
    @experience = 3
    @joined = "#{Time.now.month}/#{Time.now.day}/#{Time.now.year}"
    @admin = false
    @behance_username = "lexevan"
    @project_covers = []
  end
  
  attr_reader :joined, :admin, :full_name
  attr_accessor :fname, :lname, :email, :title, :experience, :behance_username, :project_covers

  def full_name
    "#{@fname} #{@lname}"
  end

end