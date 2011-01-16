class User < ActiveRecord::Base
  has_one :profile, :dependent => :destroy
  has_one :picture
  attr_accessible :name
end