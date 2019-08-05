class ShiftsController < ApplicationController
  def index
    @shifts = Shift.order(start_time: :asc)
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
    @shift = Shift.find(params[:id])
    if current_user.shift_hours + @shift.hours <= 40
      @shift.user = current_user
      @shift.save
      redirect_to shifts_path
    else
      flash[:notice] = "You cannot work more than 40 hours per week, you currently have scheduled #{current_user.shift_hours.to_i} hours"
      redirect_to shifts_path
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
