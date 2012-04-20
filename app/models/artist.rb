class Artist < ActiveRecord::Base
  has_many :songs
  
  # 1. The Songs table has an artist_id column
  # 2. The application defines an Song class

end