# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# logger.info "Running seed script..."


# Open up a directory
path = ARGV.last

mixtape = Mixtape.create(:name => "Pitchfork Top 100 Tracks of 2011")

Dir.foreach(path) do |filename|
  # make sure they are mp3s
  next unless filename.match(/\.mp3$/)
  puts "processing #{filename}..."

  filepath = "#{path}/#{filename}"

  mp3 = Mp3Info.open(filepath)
  song_name = mp3.tag.title
  artist_name = mp3.tag.artist

  puts "...found #{artist_name} and song #{song_name}"

  artist = Artist.find_or_create_by_name(artist_name.strip)

  song = Song.new.tap do |s|
    s.name = song_name.gsub(/\.mp3$/, "")
    s.artist = artist
    s.audio = File.new(filepath, 'r')
  end

  if song.save
    puts "...saved #{song.id} - #{song.name}"
    # mixtape.songs << song
    mixtape.mixtape_songs.create(:song => song)
  else
    puts "...error saving #{song.id} - #{song.name}"
  end

end