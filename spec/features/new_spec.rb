require 'rails_helper'

RSpec.feature "New", type: :feature do
  before do
    user = create(:user)
    login_as(user)
    visit new_dve_path
  end

  it 'should have te right path' do
    expect(current_path).to eq(new_dve_path)
  end

  it 'check error messages' do
    click_button 'Criar dve'

    expect(page).to have_content('não pode ficar em branco')
  end

  it 'when submit a valid dve' do
    fill_in 'dve[event_date]', with: '01/04/2018'
    fill_in 'dve[event_name]', with: 'Poderoso Daileon'
    fill_in 'dve[start_day]', with: '09:00'
    fill_in 'dve[end_day]', with: '17:00'
    select('Dia de semana', from: 'dve[day_kind]')

    click_button 'Criar dve'
    
    expect(page).to have_content('Dve criada com sucesso!')
  end
end
