require 'rails_helper'

RSpec.describe UserCard, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:difficulty) }
  end

  describe 'relationships' do
    it { should belong_to(:card) }
    it { should belong_to(:user) }
  end
end
