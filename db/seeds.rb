require 'faker'

puts "Deleting old shifts and users..."
Shift.destroy_all
puts "Creating shifts and users..."
admin = User.create(password: '123456', email:'samanthalricotta@gmail.com', admin: true)
# admin_shift = Shift.create(user: admin, start_time: DateTime.now, end_time: DateTime.now + 3.hours)
7.times do
  user = User.create(password: '123456')
  shift = Shift.create(start_time: DateTime.now, end_time: DateTime.now + 3.hours, user: user )
end
puts "Finished!"
