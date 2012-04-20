class Song < ActiveRecord::Base
  validates :name, :presence => true
  
  # 1. The Songs table has an artist_id column
  # 2. The application defines an Artist class
  belongs_to :artist
  has_many :genrefications
  has_many :genres, :through => :genrefications
  
end

