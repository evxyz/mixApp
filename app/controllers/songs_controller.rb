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
    @song = Song.new(params[:song])

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

    if @song.update_attributes(params[:song]) #=> {:aritst_id => 1}
     redirect_to @song
    else
      render :new
    end
  end
end
