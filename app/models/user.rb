class User < ActiveRecord::Base
  # define the relation with attempts
  has_many :attempts
  has_one :booth
  
  # remove excess spaces in name
  before_save {self.name = name.squish}

  # validations for different fields
  validates :name, presence: true, length: { maximum: 50 },
                  uniqueness: { case_sensitive: false }
  validates :password, presence: true, allow_blank: true

  # method that forces having a  password
  has_secure_password
end
