class UploadsController < ApplicationController
  
  def show
    @upload = Upload.find(params[:id])
  end

  def create
    #todo handle error
    #debugger
    @upload = Upload.new(params[:upload])
    if @upload.save
      flash[:notice] = "ok"
      respond_to do |format|
        #render :text => "ok"
        format.js { render :json => { :pic_path => @upload.picture.url.to_s , :name => @upload.picture.instance.attributes["picture_file_name"] }, :content_type => 'text/html' }
        format.html { redirect_to request.referer, :notice => "ok" }
      end
    else
      respond_to do |format|
        flash[:error] = "error"
        format.js { render :json => { :result => 'error'}}
        format.html { redirect_to request.referer, :error => "error"  }
      end
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
    @adapter = geo.width > 500 ? geo.width/500.0 : 1
    @width = geo.width
    @height = geo.height
  end

  def show_crop
    @upload = current_picture
  end
  
  def current_picture
    Upload.last #to change
  end

end