class Attempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :booth

  validates :score, presence: true
  validates_presence_of :user
  validates_presence_of :booth

  before_save do
  	last_record = self.user.best_attempts.where(booth_id: self.booth_id, is_record:true ).first
  	if last_record.nil?
  		self.is_record = true
  	elsif last_record.score < self.score
  		self.is_record = true
  	end
  end

end
