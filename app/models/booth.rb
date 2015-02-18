class Booth < ActiveRecord::Base
  has_many :attempts
  
  validates :name, presence: true
  validates :image_url, presence: true
end
