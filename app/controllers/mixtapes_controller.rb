class MixtapesController < ApplicationController

  def avi
  end


  # GET /mixtapes
  # GET /mixtapes.json
  def index
    @mixtapes = current_user.mixtapes
  end

  # GET /mixtapes/1
  # GET /mixtapes/1.json
  def show
    @mixtape = Mixtape.find(params[:id])
    current_user_can? :listen, @mixtape
  end

  # GET /mixtapes/new
  # GET /mixtapes/new.json
  def new
    @mixtape = Mixtape.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mixtape }
    end
  end

  # GET /mixtapes/1/edit
  def edit
    @mixtape = Mixtape.find(params[:id])
  end

  # POST /mixtapes
  # POST /mixtapes.json
  def create
    @mixtape = Mixtape.new(params[:mixtape])
    @mixtape.owner = current_user

    params[:songs].each do |index, song_hash|
      next if song_hash[:audio].blank?
      @mixtape.songs.build(song_hash)
    end if params[:songs]

    respond_to do |format|
      if @mixtape.save


        format.html { redirect_to @mixtape, notice: 'Mixtape was successfully created.' }
        format.json { render json: @mixtape, status: :created, location: @mixtape }
      else
        format.html { render action: "new" }
        format.json { render json: @mixtape.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mixtapes/1
  # PUT /mixtapes/1.json
  def update
    @mixtape = Mixtape.find(params[:id])

    respond_to do |format|
      if @mixtape.update_attributes(params[:mixtape])
        format.html { redirect_to @mixtape, notice: 'Mixtape was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mixtape.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mixtapes/1
  # DELETE /mixtapes/1.json
  def destroy
    @mixtape = Mixtape.find(params[:id])
    @mixtape.destroy

    respond_to do |format|
      format.html { redirect_to mixtapes_url }
      format.json { head :no_content }
    end
  end
end
