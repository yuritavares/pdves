require 'rails_helper'

RSpec.feature "MonthDetail", type: :feature do
  before do
    user = create(:user)
    login_as(user)

    @dve = create(:dve, event_date: '01/04/2018', day_kind: 'Dia_de_semana', user_id: user.id)
    @month = @dve.event_date.month
    visit("/month_detail?month=#{@month}")
  end

    it 'Edit link' do
      click_link('edit')

      expect(current_path).to eq(edit_dve_path(@dve))
    end
end
