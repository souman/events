class Event < ApplicationRecord
  has_many :user_events, :dependent => :destroy
  has_many :users, :through => :user_events

  before_save :set_end_date, :set_state

  validates :title, :starttime, presence: true

  private

  def set_end_date
    self.endtime = nil if self.allday == true
  end
  def set_state
    if self.endtime.present?
      self.state = 1 if self.endtime < Time.now
    else
      self.state = 1 if self.starttime.end_of_day < Time.now
    end
  end
end
