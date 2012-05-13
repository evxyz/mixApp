class User < ActiveRecord::Base
  has_secure_password
  has_many :mixtapes, :foreign_key => :owner_id

end
