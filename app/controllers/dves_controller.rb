class DvesController < ApplicationController
  def index
     @month = params[:date].blank? ? Date.today.month : params[:date][:month]
     @beginning_of_month = Date.parse("1/#{@month}/#{Date.today.year}").beginning_of_month
     end_of_month = @beginning_of_month.end_of_month
     @month_dves = Dve.where('event_date >= ? AND event_date <= ?', @beginning_of_month, end_of_month)
     @total_month = @month_dves.sum(:total).to_f
     @total_count = @month_dves.count
   end

  def new
    @dve = Dve.new
    @dve.event_date = params[:event_date]
  end

  def create
    @dve = Dve.new(dve_params)
    @existing_dve = Dve.find_by(event_date: dve_params[:event_date])
    
    if @existing_dve
      render :new
      return
    end

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

  def edit
    @dve = Dve.find_by(params)
  end

  def month_detail
     @month = params[:month].blank? ? Date.today.month : params[:month]
     @beginning_of_month = Date.parse("1/#{@month}/#{Date.today.year}").beginning_of_month
     end_of_month = @beginning_of_month.end_of_month
     @month_dves = Dve.where('event_date >= ? AND event_date <= ?', @beginning_of_month, end_of_month).order('event_date ASC')
     @total_month = @month_dves.sum(:total).to_f
  end
  private

  def dve_params
    params.require(:dve).permit(:event_name, :event_date, :start_day, :end_day, :overnight, :day_kind, :second_start, :second_end)
  end
end
