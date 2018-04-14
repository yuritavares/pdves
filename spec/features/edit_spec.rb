require 'rails_helper'

RSpec.feature "Edit", type: :feature do
  before do
    user = create(:user)
    login_as(user)
    @dve = create(:dve, user_id: user.id)
    visit edit_dve_path(@dve)
  end

  it 'should have te right path' do
    expect(current_path).to eq(edit_dve_path(@dve))
  end

  it 'check error messages' do
    fill_in 'dve[event_name]', with: ' '
    click_button 'Atualizar dve'

    expect(page).to have_content('não pode ficar em branco')
    expect(page).to have_content('A erros no preenchimento, não foi possivel atualizar!')
  end

  it 'when submit a valid dve' do
    fill_in 'dve[event_name]', with: 'Poderoso Daileon'

    click_button 'Atualizar dve'

    expect(page).to have_content('Dve atualizada com sucesso!')
    visit edit_dve_path(@dve)
    expect(page).to have_selector("input[value='Poderoso Daileon']")
  end
end
