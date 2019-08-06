require 'rails_helper'

RSpec.describe Shift, type: :model do
  it 'shouldnt have more than 8 hours' do
    day = Date.today
    start_time = DateTime.new(day.year, day.month, day.day , 12, 0, 0)
    end_time = DateTime.new(day.year, day.month, day.day , 22, 0, 0)
    shift = Shift.new(start_time: start_time, end_time: end_time)
    expect(shift.valid?).to be_falsey
  end

  it 'can only only be bewtween 7am and 3am' do
    day = Date.today
    start_time = DateTime.new(day.year, day.month, day.day , 4, 0, 0)
    end_time = DateTime.new(day.year, day.month, day.day , 8, 0, 0)
    shift = Shift.new(start_time: start_time, end_time: end_time)
    expect(shift.valid?).to be_falsey
  end
end
