class User < ActiveRecord::Base
  # define the relation with attempts
  has_many :attempts
  
  # remove excess spaces in name
  before_save {self.name = name.squish}

  # validations for different fields
  validates :name, presence: true, length: { maximum: 50 },
                  uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  # method that forces having a  password
  has_secure_password
end
