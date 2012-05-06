class Song < ActiveRecord::Base
  validates :name, :presence => true

  belongs_to :artist

  has_many :genrefications
  has_many :genres, :through => :genrefications

  has_many :mixtape_songs
  has_many :mixtapes, :through => :mixtape_songs

  has_attached_file :audio

  def assign_artist(opts = {})
    if opts[:artist_name].present?
      self.artist_name = opts[:artist_name]
    else
      self.artist_id = opts[:artist_id]
    end
  end

  def artist_name=(string)
    self.artist = Artist.find_or_create_by_name(string.strip)
  end

  def artist_name
    self.artist.name if self.artist
  end

  def genre_names
    self.genres.collect{|g| g.name} if self.genres.any?
  end

  [""].map do |i|
    i unless i.blank?
  end #=> [nil]




  def genre_names=(genre_names)
    updated_genres = [genre_names].flatten.map do |string|
      Genre.find_or_create_by_name(string.strip.downcase) unless string.blank?
    end

    # assign those genres to the song
    self.genres = updated_genres.compact
  end
end