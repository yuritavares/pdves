require 'rails_helper'

RSpec.describe Dve, type: :model do
  it 'is valid with event_name, event_date and day_kind' do
    dve = create(:dve)
    expect(dve).to be_valid
  end

  it 'is invalid without event_name, event_date and day_kind' do
    dve = build(:dve, event_name: nil, event_date: nil, day_kind: nil)
    expect(dve).to_not be_valid
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:event_name) }
    it { is_expected.to validate_presence_of(:event_date) }
    it { is_expected.to validate_presence_of(:day_kind) }
  end

   it { should belong_to(:user) }
   it { should define_enum_for(:day_kind) }

  describe '#calculation' do
    it  "when day_kind is equal 'Dia_de_semana'" do
      dve = create(:dve, day_kind: 'Dia_de_semana')
      expect(dve.total).to eq(18)
    end 
    
    it  "when day_kind is equal 'Feriado'" do
      dve = create(:dve, day_kind: 'Feriado')
      expect(dve.total).to eq(36)
    end 

    it  "when day_kind is equal 'Final_de_semana'" do
      dve = create(:dve, day_kind: 'Final_de_semana')
      expect(dve.total).to eq(36)
    end 

    it "when overnight equal true" do
      dve = create(:dve, day_kind: 'Final_de_semana', overnight: true)
      expect(dve.total).to eq(56)
    end
  end
end
