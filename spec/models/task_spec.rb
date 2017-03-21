require 'rails_helper'

RSpec.describe Task, type: :model do
  subject { build(:task) }

  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user_id) }
end
