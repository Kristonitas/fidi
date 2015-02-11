class User < ActiveRecord::Base
  # remove excess spaces in name
  before_save {self.name = name.squish}

  # validations for different fields
  validates :name, presence: true, length: {maximum: 50}
  validates :password, length: {minimum: 6}

  # method that forces having a  password
  has_secure_password
end
