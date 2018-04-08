require 'rails_helper'

RSpec.feature "Dves", type: :feature do
  before do
    user = create(:user)
    login_as(user)
  end

  context 'Index' do

    it 'when visit the page should be in the right path' do
      visit root_path
      p current_path
      expect(page).to have_current_path(root_path)
    end
  end
end
