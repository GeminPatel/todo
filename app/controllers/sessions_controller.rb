class SessionsController < ApplicationController

  # GET /sessions/new
  def new
  end

  # POST /sessions
  # POST /sessions.json
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      params[:session][:remember_me].eql? '1' ? remember(user) : forget(user)
      flash[:success] = 'Session was successfully created.'
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      render :new
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    log_out if logged_in?
    respond_to do |format|
      format.html { redirect_to root_path, success: 'Session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

end
