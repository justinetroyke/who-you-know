require 'rails_helper'

RSpec.describe Card, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_last_name) }
    it { should validate_presence_of(:image_url) }
  end

  describe 'relationships' do
    it { should have_many(:users) }
  end
end
