require 'rails_helper'

RSpec.describe Attachment, type: :model do
  subject { build(:attachment) }

  it { should belong_to(:task) }

  context 'mimetype' do
    it 'should not be an image' do
      expect(subject.image?).to be_falsey
    end

    it 'should be an image' do
      attachment = create(:image)
      expect(attachment.image?).to be_truthy
    end
  end

  context 'data file validations' do
    it 'should not be valid cause no file uploaded' do
      attachment = Attachment.new
      attachment.valid?
      expect(attachment.errors[:file]).to be_present
    end

    it 'should be valid' do
      attachment = Attachment.new(file: File.new(File.join(Rails.root, 'spec', 'files', '1.txt')))
      attachment.valid?
      expect(attachment.errors[:file]).to be_blank
    end
  end

  it '#url' do
    expect(subject.file.url).to be_eql("/attachments/#{subject.id}")
  end
end
