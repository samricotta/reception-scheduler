require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
  test "not valid" do
    day = Date.today.beginning_of_week
    start_time = DateTime.new(day.year, day.month, day.day , 7, 0, 0)
    end_time = DateTime.new(day.year, day.month, day.day , 20, 0, 0)
    shift = Shift.new(start_time: start_time, end_time: end_time)
    assert_equal shift.valid?, false
  end

  test "valid" do
    # day = Date.today.beginning_of_week
    start_time = Time.current
    end_time = Time.current
    shift = Shift.new(start_time: start_time, end_time: end_time)
    shift.valid?
    p shift.errors.full_messages
    assert_equal shift.valid?, true
  end
end
