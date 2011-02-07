class Upload < ActiveRecord::Base
  after_update :reprocess_picture, :if => :cropping?
  
  has_attached_file :picture, :styles => { :thumb =>  { :geometry => 'x60',
                                                         :quality => 70,
                                                         :format => 'JPG'}
                                       }
  
  validates_attachment_presence :picture
  validates_attachment_size :picture, :less_than => 5.megabytes
  validates_attachment_content_type :picture, :content_type => [ 'image/jpeg', 'image/png', 'image/pjpeg' ]
end
