require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:api_key) }
    it { should validate_presence_of(:id_token) }
  end

  describe 'relationships' do
    it { should have_many(:cards) }
    it { should have_many(:scores) }
  end
end
