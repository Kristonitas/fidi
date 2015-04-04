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

  validates :first_name, presence: true
  validates :last_name, presence: true

  # method that forces having a  password
  has_secure_password

  after_touch do
    create_qr self.id
  end
  
  after_save do
    create_qr self.id
  end

  def create_qr(id = 0)
    qr_dir = "public/qr_codes/#{id}_qr.png"
    return if File.file?(qr_dir)

    qr = RQRCode::QRCode.new( "http://79.98.25.158/attempt_for/#{id}", :size => 3, :level => :l )
    png = qr.to_img
    png.resize(256, 256).save(qr_dir)
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

  def google_qr_link
    "https://chart.googleapis.com/chart?chs=256x256&cht=qr&chl=#{qr_data}&choe=UTF-8&chld=L|0"
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
          GROUP BY users.id, users.name
          ORDER BY total_score DESC
          LIMIT 25;")
    end
  end
end
