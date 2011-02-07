module UploadsHelper
  def custom_img_tag(upload, width, height, id)
    if width > Upload::MAX_CROP_WIDTH
      image_tag upload.picture.url(:original), :id => id, :width => Upload::MAX_CROP_WIDTH, :height => (height*Upload::MAX_CROP_WIDTH/width).to_i
    else
      image_tag upload.picture.url(:original), :id => id
    end
  end
end
