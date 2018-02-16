class DvesController < ApplicationController
  def index
    @month_dves = Dve.where('event_date >= ? AND event_date <= ?', Date.today.beginning_of_month, Date.today.end_of_month)
    @total_month = @month_dves.sum(:total).to_f
    @total_count = @month_dves.count
  end

  def new
    @dve = Dve.new
    @dve.event_date = params[:event_date]
  end

  def create
    @dve = Dve.new(dve_params)
    if @dve.save
      redirect_to @dve, notice: 'Dve criada com sucesso!'
    else
      render :new
    end
  end

  def show
    @dve = Dve.find(params[:id])
  end

  private
    def dve_params
      params.require(:dve).permit(:event_name, :event_date, :start_day, :end_day, :overnight, :day_kind)
    end
end