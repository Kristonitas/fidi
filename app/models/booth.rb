class Booth < ActiveRecord::Base
  # serialize :available_scores, Array
  
  has_many :attempts
  
  validates :name, presence: true

  has_many :fidders

  before_save do
	available_scores.reject!(&:nil?) if available_scores.present?
  end

  def number_of_fidders
  	fidders.length
  end

  class << self # Class methods

    def for_code(code)
      Booth.where(code: code, userable: true).take
    end
  end
end
