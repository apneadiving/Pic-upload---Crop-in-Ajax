#ADD THIS
# this file provides refactoring for all models using paperclip
# set your own values in the model to override these
# these defaults are made for pictures (see convert_options)

Paperclip.interpolates :normalized_name do |attachment, style|
    attachment.instance.normalized_name
end

module Paperclip
  class Attachment
    def self.default_options
      if Rails.env != "production"
        @default_options = {
          :url => "/assets/:class/:attachment/:id/:style/:normalized_name",
          :path => ":rails_root/public/assets/:class/:attachment/:id/:style/:normalized_name",
          :default_url   => "/images/missing.png",
          :convert_options => { :all => '-strip -colorspace RGB'},
          :processors    => [:cropper], #[:thumbnail]
          :default_style => :original,
          :storage       => :filesystem,
          :validations   => [],
          :whiny         => Paperclip.options[:whiny] || Paperclip.options[:whiny_thumbnails]
          }
      else
        # stockage S3
        @default_options = {
          :url => "/assets/:class/:attachment/:id/:style/:normalized_name",
          :path => "/public/assets/:class/:attachment/:id/:style/:normalized_name",
          :default_url   => "/images/missing.png",
          :convert_options => { :all => '-strip -colorspace RGB'},
          :processors    => [:cropper],
          :default_style => :original,
          :validations   => [],
          :storage => :s3,
          :s3_credentials => "#{Rails.root.to_s}/config/s3.yml",
          :whiny => Paperclip.options[:whiny] || Paperclip.options[:whiny_thumbnails]
          }
      end
    end
  end
  
  module InstanceMethods
    attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
    
    #beware, works only when there is one kind of attached files/model
    def attachment_name
      self.class.attachment_definitions.first.at(0).to_s
    end
    
    def normalized_name
      eval( attachment_name + '_file_name').gsub( /[^a-zA-Z0-9_\.]/, '_') 
    end
    
    def cropping?
      !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
    end

    def picture_geometry(style = :original)
      @geometry ||= {}
      #@geometry[style] ||= Paperclip::Geometry.from_file(eval(attachment_name).path(style))
      @geometry[style] ||= Paperclip::Geometry.from_file(picture.path(style))
    end

    private

    def reprocess_picture
      #eval(attachment_name).reprocess!
      picture.reprocess!
    end
    
  end
  
end