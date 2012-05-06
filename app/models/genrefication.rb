class Genrefication < ActiveRecord::Base
  belongs_to :song
  belongs_to :genre

  validates :genre_id, :uniqueness => {:scope => :song_id}
end

