require "test_helper"

describe WorksController do
  describe 'index' do
    it "can get the index path" do
      # Act
      get works_path
      
      # Assert
      must_respond_with :success
    end
    
    it "can get the root path" do
      # Act
      get root_path
      
      # Assert
      must_respond_with :success
    end
  end
end
