require 'rails_helper'

RSpec.describe User, type: :model do
  it 'shouldnt have more than 40 hours in a week' do
    day = Date.today
    user = User.create(email:'test@test.com', password:'123456')
    2.times do
      morning_start = DateTime.new(day.year, day.month, day.day, 7, 0, 0)
      morning_end = DateTime.new(day.year, day.month, day.day, 15, 0, 0)
      afternoon_start = DateTime.new(day.year, day.month, day.day, 15, 0, 0)
      afternoon_end = DateTime.new(day.year, day.month, day.day, 23, 0, 0)
      Shift.create(start_time: morning_start, end_time: morning_end, user: user)
      Shift.create(start_time: afternoon_start, end_time: afternoon_end, user: user)
      day = day + 1.day
    end
    night_start = DateTime.new(day.year, day.month, day.day , 19, 0, 0)
    night_end = DateTime.new(day.year, day.month, day.day , 21, 0, 0)
    invalid_start = DateTime.new(day.year, day.month, day.day + 1, 7, 0, 0)
    invalid_end = DateTime.new(day.year, day.month, day.day + 1, 15, 0, 0)
    Shift.create(start_time: night_start, end_time: night_end, user: user)
    shift = Shift.create(start_time: invalid_start, end_time: invalid_end, user: user)
    expect(shift.valid?).to be_falsey
  end
end
