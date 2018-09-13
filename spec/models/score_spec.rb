require 'rails_helper'

RSpec.describe Score, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:difficulty) }
    it { should validate_presence_of(:num_played) }
    it { should validate_presence_of(:num_correct) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
  end
end
