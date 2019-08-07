class Shift < ApplicationRecord
  belongs_to :user, optional: true

  validates :start_time, :uniqueness => {:scope => :end_time}
  validates :start_time, :end_time, presence: true
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
    same_day = end_time.day == start_time.day
    diff_day = end_time.day != start_time.day
    if same_day && start_time.hour >= 7
      earliest = DateTime.new(start_time.year, start_time.month, start_time.day, 7, 0, 0)
      latest = DateTime.new(start_time.year, start_time.month, start_time.day, 23, 59, 0)
      unless start_time.between?(earliest, latest) && end_time.between?(earliest, latest)
        self.errors[:base] << "Shift is not within opening hours (7:00 to 23:59)"
      end
    elsif same_day && start_time.hour < 7
      earliest = DateTime.new(start_time.year, start_time.month, start_time.day, 0, 0, 0)
      latest = DateTime.new(start_time.year, start_time.month, start_time.day, 3, 0, 0)
      unless start_time.between?(earliest, latest) && end_time.between?(earliest, latest)
        self.errors[:base] << "Shift is not within opening hours (0:00 to 3:00)"
      end
    elsif diff_day
      earliest = DateTime.new(start_time.year, start_time.month, start_time.day, 7, 0, 0)
      latest = DateTime.new(start_time.year, start_time.month, start_time.day + 1, 3, 0, 0)
      unless start_time.between?(earliest, latest) && end_time.between?(earliest, latest)
        self.errors[:base] << "Shift is not within opening hours (7:00 to 3:00)"
      end
    end
  end

  def number_of_hours_below_8
    if hours > 8
      self.errors[:base] << "Shift cannot be anymore more than 8 hours, its now #{hours.to_i} hours"
    end
  end

  def user_less_than_40_hours
    if user && user.shift_hours + hours > 40
      self.errors[:base] << "You cannot work more than 40 hours per week"
    end
  end
end
