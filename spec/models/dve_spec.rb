require 'rails_helper'

RSpec.describe Dve, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:event_name) }
    it { is_expected.to validate_presence_of(:event_date) }
    it { is_expected.to validate_presence_of(:overnight) }
  end
end
