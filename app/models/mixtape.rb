class Mixtape < ActiveRecord::Base
  has_many :mixtape_songs
  has_many :songs, :through => :mixtape_songs
  
  def songs_to_add_by_song_id=(song_ids)
    # Add the Songs in song_ids to the mixtape
    self.songs << song_ids.map{|song_id| Song.find song_id}
  end
  
end


