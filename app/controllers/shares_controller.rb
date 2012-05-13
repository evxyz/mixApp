class SharesController < ApplicationController
  def new
    @mixtape = Mixtape.find(params[:mixtape_id])
  end

  def create
    @mixtape = Mixtape.find(params[:mixtape_id])
    @user = User.find_by_email(params[:email])
    @user && @mixtape.add_user(@user, :listen)
    redirect_to @mixtape, :notice => "Shared with #{@user.email}!"
  end
end
