require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { should respond_to(:email) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_length_of(:password).is_at_least(8).is_at_most(72) }
  it { should validate_confirmation_of(:password) }
  it { should have_many(:tasks).dependent(:destroy) }
end
