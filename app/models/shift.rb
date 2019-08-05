class Shift < ApplicationRecord
  belongs_to :user, optional: true

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates_time :start_time, :on_or_after => '7:00am', :on_or_after_message => 'must be after opening time'
  validates_time :end_time, :on_or_before => ['0:00am','3:00am'], :on_or_before_message => 'must be before closing time'
  validate :number_of_hours_below_8


  def formatted_start_time
    start_time.strftime("%A #{start_time.day.ordinalize} %B - %H:%M")
  end

  def formatted_end_time
    end_time.strftime("%A #{end_time.day.ordinalize} %B - %H:%M")
  end

  private

  def number_of_hours_below_8
    total_hours = ((end_time.to_time - start_time) / 1.hours)
    if total_hours > 8
      self.errors[:base] << "Shift cannot be anymore more than 8 hours, its now #{total_hours.to_i} hours"
    end
  end
end
