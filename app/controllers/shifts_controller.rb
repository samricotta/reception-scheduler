class ShiftsController < ApplicationController
  before_action :set_shift, only: [:destroy, :update]
  before_action :set_asc_shifts, only: [:index]
  def index
  end

  def new
    @shift = Shift.new
  end

  def create
    @shift = Shift.new(shift_params)
    if @shift.save
      redirect_to shifts_path
    else
      render :new
    end
  end

  def update
    @shift.user = current_user
    if @shift.save
      redirect_to shifts_path
    else
      set_asc_shifts
      render :index
    end
  end

  def destroy
    @shift.destroy
    redirect_to shifts_path
  end

  private

  def set_asc_shifts
    @shifts = Shift.order(start_time: :asc)
  end

  def set_shift
    @shift = Shift.find(params[:id])
  end

  def shift_params
    params.require(:shift).permit(:number_of_hours, :start_time, :end_time)
  end
end
