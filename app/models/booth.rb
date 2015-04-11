class Booth < ActiveRecord::Base
  # serialize :available_scores, Array
  
  has_many :attempts
  
  validates :name, presence: true
  validates :max_attempts, presence: true

  has_many :fidders

  before_save do
	available_scores.reject!(&:nil?) if available_scores.present?
  end

  def image_url
    if popup_image.empty?
      ""
    elsif popup_image.start_with?('http')
      popup_image
    else
      # 'http://79.98.25.158/booths/' + popup_image
      'img/booths/' + popup_image
    end
  end

  def pointer_image_url
    if pointer_image.nil?
      ""
    elsif pointer_image.start_with?('http')
      pointer_image
    else
      # 'http://79.98.25.158/pointers/' + pointer_image
      'img/pointers/' + pointer_image
    end
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
