class Picture < ActiveRecord::Base
  belongs_to :user
  after_update :reprocess_picture, :if => :cropping?
  
  has_attached_file :picture, :styles => { :thumbs =>  { :geometry => 'x60',
                                                         :quality => 70,
                                                         :format => 'JPG'},
                                        :small =>  { :geometry => 'x400',
                                                      :quality => 70,
                                                      :format => 'JPG'}
                                       }
  #attr_accessible :picture, :profile_id
  
  validates_attachment_presence :picture
  validates_attachment_size :picture, :less_than => 5.megabytes
  validates_attachment_content_type :picture, :content_type => [ 'image/jpeg', 'image/png' ]
  
end