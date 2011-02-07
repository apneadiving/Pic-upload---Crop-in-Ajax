class UploadsController < ApplicationController
  
  def show
    @upload = Upload.find(params[:id])
  end

  def create
    @upload = Upload.new(params[:upload])
    if @upload.save
      render :json => { :pic_path => @upload.picture.url.to_s , :name => @upload.picture.instance.attributes["picture_file_name"] }, :content_type => 'text/html'
    else
      #todo handle error
      render :json => { :result => 'error'}, :content_type => 'text/html'
    end
  end
  
  def update
    @upload = Upload.find(params[:id])
    if @upload.update_attributes(params[:upload])
      flash[:notice] = "Successfully updated picture."
      redirect_to root_path
    end
  end

  def show_pic
    @upload = current_picture
    geo = Paperclip::Geometry.from_file(@upload.picture.to_file(:original))
    @adapter = geo.width > Upload::MAX_CROP_WIDTH.to_f ? geo.width/Upload::MAX_CROP_WIDTH.to_f : 1
    @width = geo.width
    @height = geo.height
  end

  def show_crop
    @upload = current_picture
  end
  
  def current_picture
    Upload.last #to change according to what you expect, example: current_user.avatar
  end

end