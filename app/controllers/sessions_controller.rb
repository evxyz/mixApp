class SessionsController < ApplicationController
  skip_before_filter :login_required

  def new
  end

  def create
    # load the user from their email
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      back_to = session[:back_to] || '/'
      redirect_to back_to
    else
      render :new, :notice => "Unable to Login"
    end
  end

  def destroy
    reset_session
    redirect_to '/login'
  end

end
