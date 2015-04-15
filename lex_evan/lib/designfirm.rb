class DesignFirm 
  def initialize(name,website,phone,email,address,staff_size)
    @name = name
    @website = website
    @phone = phone
    @email = email
    @address = address
    @staff_size = staff_size
    @joined = "#{Time.now.month}/#{Time.now.day}/#{Time.now.year}"
  end

  attr_accessor :name, :joined, :website, :phone, :email, :address, :staff_size
end