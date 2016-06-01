class Contact < ActiveRecord::Base
  has_many :numbers
  validates_presence_of :first_name, :last_name, :email


  def full_name
    self.first_name + " " + self.last_name
  end

end
