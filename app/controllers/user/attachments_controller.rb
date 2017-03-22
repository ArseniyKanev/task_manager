class User::AttachmentsController < ApplicationController

  before_action :auth
  load_and_authorize_resource

  def show
    if @attachment.image?
      send_data File.open(@attachment.file.path, 'rb').read, type: @attachment.file.file.content_type, disposition: 'inline'
    else
      send_file @attachment.file.path, type: @attachment.file.file.content_type, filename: @attachment.file.file.filename, stream: false
    end
  end

end
