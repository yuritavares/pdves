class DvesController < ApplicationController
  before_action :authenticate_user!

  def index
     @month = params[:event_date].blank? ? Date.today.month : params[:event_date][:month]
     @beginning_of_month = Date.parse("1/#{@month}/#{Date.today.year}").beginning_of_month
     end_of_month = @beginning_of_month.end_of_month
     @month_dves = current_user.dves.where('event_date >= ? AND event_date <= ?', @beginning_of_month, end_of_month)
     @total_month = @month_dves.sum(:total).to_f
     @total_count = @month_dves.count
   end

  def new
    @dve = current_user.dves.new
    @dve.event_date = params[:event_date]
  end

  def create
    @dve = current_user.dves.new(dve_params)
    @existing_dve = current_user.dves.find_by(event_date: dve_params[:event_date])

    if @existing_dve
      render :new
      return
    end

    @dve = current_user.dves.new(dve_params)
    if @dve.save
      redirect_to @dve, notice: 'Dve criada com sucesso!'
    else
      render :new
    end
  end

  def show
    @dve = current_user.dves.find(params[:id])
  end

  def edit
    @dve = current_user.dves.find(params[:id])
  end

  def update
    @dve = current_user.dves.find(params[:id])

    if @dve.update(dve_params)
      redirect_to month_detail_path, notice: 'Dve atualizada com sucesso!'
    else
      flash[:alert] = "A erros no preenchimento, não foi possivel atualizar!"
      render :edit
    end
  end

  def destroy
    @dve = current_user.dves.find(params[:id])
    @dve.destroy
    redirect_to month_detail_path, notice: 'Dve deletada com sucesso!'
  end

  def month_detail
     @month = params[:month].blank? ? Date.today.month : params[:month]
     @beginning_of_month = Date.parse("1/#{@month}/#{Date.today.year}").beginning_of_month
     end_of_month = @beginning_of_month.end_of_month
     @month_dves = current_user.dves.where('event_date >= ? AND event_date <= ?', @beginning_of_month, end_of_month).order('event_date ASC')
     @total_month = @month_dves.sum(:total).to_f
  end
  
  private

  def dve_params
    params.require(:dve).permit(:event_name, :event_date, :start_day, :end_day, :overnight, :day_kind, :second_start, :second_end)
  end
end
