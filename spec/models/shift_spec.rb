require 'rails_helper'

RSpec.describe Shift, type: :model do
  # zone = ActiveSupport::TimeZone.new('Hawaii')
  # Time.stub(:now){ Time.new.in_time_zone(zone) }

  # context 'when requesting the shifts page' do
    it 'displays start time with user timezone', tz: 'Pacific Time (US & Canada)' do
      user_timezone = 'Brasilia'
      # start_date = Time.zone.parse('2017-12-31 23:00:00')
      day = Time.zone.now
      p start_time = DateTime.new(day.year, day.month, day.day , 8, 0, 0)
      p end_time = DateTime.new(day.year, day.month, day.day , 10, 0, 0)
      shift = Shift.create(start_time: start_time, end_time: end_time)
      p shift
      # it { is_expected.to validates_time(:start_time).between(['0:00am', '3:00am']) }
      # expect(shift.valid?).to be_falsey
      p shift.errors.full_messages
      # p shift = Shift.new(start_time: start_time, end_time: end_time)
      expect(shift.valid?).to be_falsey
    end

    it 'can only only be bewtween 7am and 3am' do
      day = Date.today.beginning_of_week
      start_time = DateTime.new(day.year, day.month, day.day , 10, 0, 0)
      end_time = DateTime.new(day.year, day.month, day.day , 14, 0, 0)
      shift = Shift.new(start_time: start_time, end_time: end_time).save
      expect(shift.valid?).to be_falsey
    end
  # end
end
