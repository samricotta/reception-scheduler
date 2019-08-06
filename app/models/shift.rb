class Shift < ApplicationRecord
  belongs_to :user, optional: true

  validates :start_time, :uniqueness => {:scope => :end_time}
  validates :start_time, :end_time, presence: true
  # validates_time :start_time, :on_or_after => '7:00am', :on_or_after_message => 'must be after opening time'
  validate :within_opening_hours
  validate :number_of_hours_below_8
  validate :user_less_than_40_hours


  def formatted_start_time
    start_time.strftime("%A #{start_time.day.ordinalize} %B - %H:%M")
  end

  def formatted_end_time
    end_time.strftime("%A #{end_time.day.ordinalize} %B - %H:%M")
  end

  def hours
    (end_time.to_time - start_time) / 1.hours
  end

  private

  def within_opening_hours
    if start_time > end_time
      self.errors[:base] << "Start time must be before end"
    end
    latest = DateTime.new(start_time.year, start_time.month, start_time.day + 1, 3, 0, 0)
    if (end_time.day != start_time.day && end_time > latest) || ( start_time.hour >= 3  && start_time.hour < 7) || (end_time.hour > 3 && end_time.hour < 7)
      self.errors[:base] << "Shift is not within opening hours"
    end
  end

  def number_of_hours_below_8
    total_hours = hours
    if total_hours > 8
      self.errors[:base] << "Shift cannot be anymore more than 8 hours, its now #{total_hours.to_i} hours"
    end
  end

  def user_less_than_40_hours
    if user && user.shift_hours + hours > 40
      self.errors[:base] << "You cannot work more than 40 hours per week, you currently have scheduled"
    end
  end
end
