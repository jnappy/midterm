class Congressppl
  attr_accessor :first_name, :last_name, :party, :chamber, :district, :email

  def initialize (first_name, last_name, party, chamber, district, email)
    @first_name = first_name
    @last_name = last_name
    @party = party
    @chamber = chamber
    @district = district
    @email = email
    #@@instance_collecter << self
  end


  def firstname
    @first_name
  end
  #def self.viewall
   #@@instance_collecter
  #end

end