class ShiftsController < ApplicationController
  def index
    @shifts = Shift.all
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
    if current_user.shift_hours <= 40
      @shift = Shift.find(params[:id])
      @shift.user = current_user
      @shift.save
      redirect_to shifts_path
    else
      render :index
    end
  end

  def destroy
    @shift = Shift.find(params[:id])
    @shift.destroy
    redirect_to shifts_path
  end

  private

  def shift_params
    params.require(:shift).permit(:number_of_hours, :start_time, :end_time)
  end
end
