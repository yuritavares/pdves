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

    it 'Delete link' do
      page.accept_confirm do
        click_link 'Delete'
      end

      expect(current_path).to eq("/month_detail?month=#{@month}")
      expect(page).to_not have_content('MyString')
    end
end
