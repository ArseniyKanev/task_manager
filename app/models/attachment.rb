class Attachment < ActiveRecord::Base

  mount_uploader :file, AttachmentUploader

  belongs_to :task

  validates :file, presence: true

  def image?
    file&.file&.content_type =~ %r{image\/.*}
  end

end
