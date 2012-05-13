class User < ActiveRecord::Base
  has_secure_password
  has_many :owned_mixtapes, :foreign_key => :owner_id, :class_name => 'Mixtape'

  has_many :user_mixtapes
  has_many :mixtapes, :through => :user_mixtapes
end
