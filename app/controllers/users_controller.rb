class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    if @user.nil?
      head :not_found
      return
    end
  end

  def login_form
    @user = User.new 
  end

  def login
    username = params[:user][:name]
    user = User.find_by(name: username)
    if user
      session[:user_id] = user.id
      flash[:success] = "Welcome back, #{username}!"
    else
      user = User.create(name: username)
      session[:user_id] = user.id
      flash[:success] = "Successfully created new user #{username} with ID #{user.id}"
    end

    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end

  def current
    @user = User.find_by(id: session[:user_id])
    if !@user
      flash[:warning] = "You must be logged in to see this page"
      redirect_to root_path
      return
    end
  end

end
