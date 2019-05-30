namespace :import do
  desc "import users"
  task :users => :environment do |t|
    users_data = SmarterCSV.process("db/users.csv")
    users_data.each do |ud|
      User.new(ud).save!
    end
  end
end