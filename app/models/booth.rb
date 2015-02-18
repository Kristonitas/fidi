class Booth < ActiveRecord::Base
  has_many :attempts
  
  validates :name, presence: true
end
