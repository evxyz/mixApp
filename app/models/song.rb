class Song < ActiveRecord::Base
  validates :name, :presence => true
  
  belongs_to :artist
  
  has_many :genrefications
  has_many :genres, :through => :genrefications
  
  has_many :mixtape_songs
  has_many :mixtapes, :through => :mixtape_songs
  
  def artist_name=(string)
    self.artist = Artist.find_or_create_by_name(string)
  end

  def artist_name
    self.artist.name if self.artist
  end
  
  def genre_names=(genre_names)
    updated_genres = genre_names.map do |string|
      Genre.find_or_create_by_name(string.strip.downcase) 
    end

    # assign those genres to the song
    self.genres = updated_genres
  end
end