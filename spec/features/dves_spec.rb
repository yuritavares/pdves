require 'rails_helper'

RSpec.feature "Dves", type: :feature do
  before do
    user = create(:user)
    login_as(user)

    dve1 = create(:dve, event_date: '01/04/2018', day_kind: 'Dia_de_semana', user_id: user.id)
    dve2 = create(:dve, event_date: '02/04/2018', day_kind: 'Dia_de_semana', user_id: user.id)
  end

  context 'Index' do
    before do
      visit root_path
    end

    it 'when visit the page should be in the right path' do
      expect(current_path).to eq(root_path)
    end

    it "clicking button 'Cadastrar DVE' without pick a date" do
      click_button('Cadastrar DVE')

      expect(current_path).to eq(new_dve_path)
    end

    it "passing a picked date before click in 'Cadastrar DVE'" do
      fill_in 'event_date[]', with: '01/04/2018'
      click_button('Cadastrar DVE')

      expect(page).to have_selector("input[value='01/04/2018']")
    end

    it 'listing dves values for the requested month' do
      select('Abril', from: 'date[month]')
      click_button 'listar valores'

      expect(page).to have_content('R$ 36')
      expect(page).to have_content('2 dias')
    end

    it 'more details for the requested month' do
      select('Abril', from: 'date[month]')
      click_button 'listar valores'
      click_link 'Clique aqui para mais detalhes do mês'

      expect(current_path).to eq(month_detail_path)
      expect(page).to have_content('Abril')
      expect(page).to have_content('02/04')
    end
  end
end
