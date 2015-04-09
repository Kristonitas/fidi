class Booth < ActiveRecord::Base
  has_many :attempts
  
  validates :name, presence: true

  has_many :fidders

  def number_of_fidders
  	fidders.length
  end
end
