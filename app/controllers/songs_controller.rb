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

    if @song.update_attributes(slice_params(params[:song])) #=> {:aritst_id => 1}
     redirect_to @song
    else
      render :new
    end
  end

  private
    def slice_params(params)
      params.except(:artist_id, :artist_name)
    end
end
