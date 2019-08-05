require 'faker'

puts "Deleting old shifts and users..."
Shift.destroy_all
puts "Creating shifts and users..."
day = Date.today.beginning_of_week
admin = User.create(password: '123456', email:'test@test.com', admin: true)
7.times do
  seven = DateTime.new(day.year, day.month, day.day , 7, 0, 0)
  two = DateTime.new(day.year, day.month, day.day , 14, 0, 0)
  nine = DateTime.new(day.year, day.month, day.day , 21, 0, 0)
  three = DateTime.new(day.year, day.month, day.day + 1, 3, 0, 0)

  puts "Create a shift - #{seven.strftime("%b %d - %H:%M")} | #{two.strftime("%b %d - %H:%M")}"
  Shift.create(start_time: seven, end_time: two)
  puts "Create a shift - #{two.strftime("%b %d - %H:%M")} | #{nine.strftime("%b %d - %H:%M")}"
  Shift.create(start_time: two, end_time: nine)
  puts "Create a shift - #{nine.strftime("%b %d - %H:%M")} | #{three.strftime("%b %d - %H:%M")}"
  Shift.create(start_time: nine, end_time: three)
  day = day + 1.day
end
puts "Finished!"
