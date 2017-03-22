class AttachmentUploader < CarrierWave::Uploader::Base

  storage :file

  def store_dir
    "attachments/#{model.id}"
  end

end
