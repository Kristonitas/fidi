class User < ActiveRecord::Base
  # define the relation with attempts
  # if will use the paswords for default user, might recreate with devise...
  has_many :attempts
  
  # remove excess spaces in name
  before_save {self.name = name.squish}

  # validations for different fields
  validates :name, presence: true, length: { maximum: 50 },
                  uniqueness: { case_sensitive: false }
  validates :password, presence: true, allow_blank: true

  # method that forces having a  password
  has_secure_password
  
  after_save do
        qr = RQRCode::QRCode.new( "http://79.98.25.158/attempt_for/#{self.id}", :size => 3, :level => :l )
        png = qr.to_img
        png.resize(256, 256).save("public/qr_codes/#{self.id}_qr.png")
  end

  def total_score
    attempts.where(is_record: true).sum(:score)
  end

  def best_attempts
    attempts.where(is_record: true)
  end

  def qr_link
    "http://79.98.25.158/qr_codes/#{self.id}_qr.png"
  end

  def qr_data
    "http://79.98.25.158/attempt_for/#{self.id}"
  end

  class << self # Class methods
    def leaderboard
      User.find_by_sql(
          "SELECT users.*, SUM(attempts.score) AS total_score
          FROM attempts
          LEFT JOIN users
          ON attempts.user_id=users.id
          WHERE attempts.is_record=TRUE
          GROUP BY users.id, users.name;")
    end
  end
end
