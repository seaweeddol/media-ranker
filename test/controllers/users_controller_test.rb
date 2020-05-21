require "test_helper"

describe UsersController do
  describe "login" do
    it "creates new user if user does not exist yet" do
      expect {
        perform_login
      }.must_differ "User.count", 1
    end

    it "logs into existing user if user already exists" do
      user = User.create(name: "test user")
      login_data = {
        user: {
          name: user.name,
        },
      }
      post login_path, params: login_data
  
      expect(session[:user_id]).must_equal user.id
      expect(flash[:success]).must_include "Welcome back"
    end
  end

  describe "login_form" do
    it "can get the login_form path" do
      # Act
      get login_path
      
      # Assert
      must_respond_with :success
    end
  end

  describe "logout" do
    it "sets session user id to nil and redirects to root" do
      perform_login

      logout_data = {
        user: {
          name: User.find(session[:user_id]).name,
        },
      }

      post logout_path, params: logout_data

      expect(session[:user_id]).must_equal nil
      must_redirect_to root_path
    end
  end

  describe "current" do
    it "returns 200 OK for a logged-in user" do
      # Arrange
      perform_login

      # Act
      get current_user_path

      # Assert
      must_respond_with :success
    end

    it "redirects to root path if user is not logged in" do
      # Act
      get current_user_path

      # Assert
      expect(flash[:error]).must_equal "You must be logged in to see this page"
      must_redirect_to root_path
    end
  end
end
