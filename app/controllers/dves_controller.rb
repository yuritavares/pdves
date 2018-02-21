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

    # antes de salvar uma nova dve, tenta encontrar uma outra com a mesma data que vc mandou nos parametros
    @existing_dve = Dve.find_by(event_date: dve_params[:event_date])

    # se por acaso existir, manda um render new pra renderizar a view do formulário
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

  private

  def dve_params
    params.require(:dve).permit(:event_name, :event_date, :start_day, :end_day, :overnight, :day_kind, :second_start, :second_end)
  end
end
