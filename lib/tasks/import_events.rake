namespace :import do
  desc "import events"
  task :events => :environment do |t|
    rsvp_mappings = {'no': 0, 'yes': 1, 'maybe': 2}
    users = User.all.pluck(:username, :id).map.to_h
    events_data = SmarterCSV.process("db/events.csv")
    events_data.each do |ed|      
      user_events = ed.delete("users#rsvp".to_sym).try(:split, ';')
      event = Event.create(ed)
      if !user_events.nil?
        user_events.each do |ue|
          user_events_data = ue.split('#')
          event.user_events.new(user_id: users[user_events_data[0]], rsvp: rsvp_mappings[user_events_data[1].to_sym]).save!
        end
      end
    end
  end
end