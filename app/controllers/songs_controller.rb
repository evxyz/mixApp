class SongsController < ApplicationController

  def index
    @songs = Song.all
  end

  def show
    @song = Song.find params[:id]
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(slice_params(params[:song]))
    @song.assign_artist(params[:song])

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find params[:id]
  end

  def update
    @song = Song.find(params[:id])
    @song.assign_artist(params[:song])

    # "'new_genre_name', 1"

    params[:song][:genre_names].split(",").each do |genre_token|
      genre = if genre_token.is_numeric?
        Genre.find(genre_token)
      else
        Genre.find_or_create_by_name(genre_token.gsub("'", ""))
      end

      genrefication = @song.genrefications.build(:genre => genre)
      genrefication.save
    end

    if @song.update_attributes(slice_params(params[:song])) #=> {:aritst_id => 1}
     redirect_to @song
    else
      render :new
    end
  end

  private
    def slice_params(params)
      params.except(:artist_id, :artist_name, :genre_names)
    end
end
