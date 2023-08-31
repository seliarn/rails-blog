module ArticlesHelper

  # Checks if the given content type corresponds to an image type.
  #
  # @param type [String] The content type of the file.
  # @return [Boolean] `true` if the content type corresponds to an image; otherwise, `false`.
  def is_image(type)
    !!(type =~ /^image\/(jpeg|jpg|gif|png|bmp|svg\+xml)$/)
  end

  # Uploads an image file if it exists and is of an image type.
  #
  # @param file [ActionDispatch::Http::UploadedFile] The uploaded file to be checked and uploaded.
  # @return [String] The original filename of the uploaded image if it was successfully uploaded; otherwise, `nil`.
  def upload_image_if_exists(file)
    if !file.blank? && is_image(file.content_type)
      filepath = Rails.root.join("storage").to_s + '/' + file.original_filename
      File.open(filepath, 'wb') do |f|
        f.write file.read
      end

      file.original_filename
    end
  end
end
