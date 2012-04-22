class Genre < ActiveRecord::Base
  has_many :genrefications
  has_many :songs, :through => :genrefications
  
  validates_presence_of :name
end
