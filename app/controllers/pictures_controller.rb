#ADD THIS: A SEPARATE CONTROLLER + IT'S VIEWS.
# for commodity, I added them as a subfolder in profile

require 'mime/types'

class PicturesController < ApplicationController
    
  def show
    @picture = Picture.find(params[:id])
    render '/profiles/pictures/show'
  end

  def create
    #todo handle error
    current_user.picture.delete unless current_user.picture.nil?
    params[:user_id] = current_user.id
    new_params = coerce(params)    
    @picture = Picture.new(new_params[:picture])
    if @picture.save
      respond_to do |format|
        format.json { render :json => { :result => 'success', :picture => picture_path(@picture) } }
      end
    else
      format.json { render :json => { :result => 'error'} }
    end
  end

  def update
    @picture = Picture.find(params[:id])
    if @picture.update_attributes(params[:picture])
      flash[:notice] = "Successfully updated picture."
      render '/profiles/pictures/show'
    end
  end
  
  def show_pic
    @picture_model = current_user.picture
    #Picture.last #TODO change this!
    geo = Paperclip::Geometry.from_file(@picture_model.picture.to_file(:original))
    @adapter = geo.width > 500 ? geo.width/500.0 : 1
    @width = geo.width
    @height = geo.height
    render '/profiles/pictures/show_pic'
  end
  
  def show_crop
    @picture_model = current_user.picture
    render '/profiles/pictures/show_crop'
  end
  
  private
  
  def coerce(params)
    if params[:picture].nil?
      h = Hash.new
      h[:picture] = Hash.new
      h[:picture][:user_id] = params[:user_id]
      h[:picture][:picture] = params[:Filedata]
      h[:picture][:picture].content_type = MIME::Types.type_for(h[:picture][:picture].original_filename).to_s
      h
    else
      params
    end
  end
  
  def current_user
    User.first
  end
end
