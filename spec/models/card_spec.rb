require 'rails_helper'

RSpec.describe Card, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_last_name) }
    it { should validate_presence_of(:company) }
    it { should validate_presence_of(:school) }
    it { should validate_presence_of(:job_title) }
    it { should validate_presence_of(:image_url) }
    it { should validate_presence_of(:profile_url) }
  end

  describe 'relationships' do
    it { should have_many(:users) }
  end
end
