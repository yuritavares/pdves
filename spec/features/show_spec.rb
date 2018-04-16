require 'rails_helper'

RSpec.feature "Show", type: :feature do
   before do
     @user = create(:user)
     login_as(@user)


     dve = create(:dve, user_id: @user.id)
     visit dve_path(dve)
   end

   it 'check elements on page' do
     expect(page).to have_content('Evento: MyString')
     expect(page).to have_content('Entrada: 13:23')
     expect(page).to have_content('Saida: 13:23')
     expect(page).to have_content('Segunda entrada: 13:23')
     expect(page).to have_content('Segunda saida: 13:23')
     expect(page).to have_content('Pernoite: Não')
     expect(page).to have_content('Total em dve: R$ 36.0')
   end

   it 'when second start/end is not present' do
     dve = create(:dve, user_id: @user.id, second_start: nil, second_end: nil)
     visit dve_path(dve)

     expect(page).to_not have_content('Segunda entrada:')
     expect(page).to_not have_content('Segunda saida:')
   end
end
