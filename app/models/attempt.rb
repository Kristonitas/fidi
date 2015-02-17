class Attempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :booth

  validates :points, presence: true
  validates_presence_of :user
  validates_presence_of :booth
end
