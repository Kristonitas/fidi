class User < ActiveRecord::Base
  # define the relation with attempts
  # if will use the paswords for default user, might recreate with devise...
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

  def best_attempts
    attempts.where(is_record: true)
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
