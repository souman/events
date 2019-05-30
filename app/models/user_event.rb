class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  before_save :set_rsvp

  validates :user_id, :event_id, presence: true

  private
  def set_rsvp
    if(self.rsvp==1)
      start_time = self.event.starttime
      end_time = self.event.endtime.present? ? self.event.endtime : self.event.starttime.end_of_day
      over_lapping_event_ids = self.user.events.where("endtime >= ? and endtime <= ?", start_time, end_time).pluck(:id)
      over_lapping_event_ids += self.user.events.where("starttime >= ? and starttime <= ?", start_time, end_time).pluck(:id)

      UserEvent.where(event_id: over_lapping_event_ids, rsvp: 1, user_id: self.user_id).update_all(rsvp: 0)
    end
  end
end
