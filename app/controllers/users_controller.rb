class UsersController < ApplicationController
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
end
