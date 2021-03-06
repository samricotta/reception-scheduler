class User < ApplicationRecord
  has_many :shifts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 def shift_hours
    total_hours = 0
    monday = Date.today.beginning_of_week
    collected_shifts = shifts.where('start_time > ?', monday).all
    collected_shifts.each do |shift|
      total_hours += shift.hours
    end
    total_hours
  end
end
