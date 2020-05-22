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

  describe "show" do
    it "responds with success when showing an existing valid work" do
        # Act
        get work_path(Work.first.id)
        
        # Assert
        must_respond_with :success
    end

    it "responds with 404 with an invalid work id" do
        # Act
        get work_path(99999)
        
        # Assert
        must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
        # Act
        get new_work_path
        
        # Assert
        must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new work with valid information accurately, and redirect" do
      # Arrange
      work_hash = {
        work: {
          title: "new work",
          category: "new work category",
          creator: "a creator"
        },
      }
      
      # Act-Assert
      expect {
        post works_path, params: work_hash
      }.must_change "Work.count", 1
      
      new_work = Work.find_by(title: work_hash[:work][:title])
      expect(new_work.title).must_equal work_hash[:work][:title]
      expect(new_work.category).must_equal work_hash[:work][:category]
      expect(new_work.creator).must_equal work_hash[:work][:creator]
      # expect(flash[:success]).must_include "added successfully"

      must_redirect_to work_path(new_work.id)
    end

    it "does not create a work if the form data violates work validations, and responds with a redirect" do
      work_hash = {
        work: {
          name: "new work",
          category: nil,
        },
      }
      
      # Act-Assert
      expect {
        post works_path, params: work_hash
      }.must_differ "Work.count", 0
            
      must_respond_with :bad_request
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid work" do
      get edit_work_path(Work.first.id)
      
      # Assert
      must_respond_with :success
    end
      

    it "responds with redirect when getting the edit page for a non-existing work" do
      get edit_work_path(-1)
      
      # Assert
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "can update an existing work with valid information accurately, and redirect" do
      # Assert
      work_hash = {
        work: {
          title: "a new title",
          category: "movie",
          creator: "a new creator"
        },
      }

      work = Work.first 
      
      # Act-Assert
      expect {
        patch work_path(work[:id]), params: work_hash
      }.must_differ "Work.count", 0

      updated_work = Work.find_by(title: work_hash[:work][:title])
      expect(updated_work.title).must_equal work_hash[:work][:title]
      expect(updated_work.category).must_equal work_hash[:work][:category]
      expect(updated_work.creator).must_equal work_hash[:work][:creator]

      expect(flash[:success]).must_include "Successfully updated"
      must_redirect_to work_path(updated_work.id)
    end

    it "does not update any work if given an invalid id, and responds with a 404" do
      # Arrange
      work_hash = {
        work: {
          title: "a new title",
          category: "movie",
          creator: "a new creator"
        },
      }
      
      # Act-Assert
      expect {
        patch work_path(97777), params: work_hash
      }.must_differ "Work.count", 0

      expect(flash[:warning]).must_equal "This work does not exist"
      must_respond_with :not_found
    end

    it "does not update a work if the form data violates work validations, and responds with a redirect" do
      work_hash = {
        work: {
          title: nil,
        },
      }
       
      work = Work.first 

      # Act-Assert
      # Ensure that there is no change in Work.count
      expect {
        patch work_path(work[:id]), params: work_hash
      }.must_differ "Work.count", 0

      # Assert
      # Check that the controller redirects
      expect(flash[:warning]).must_include "A problem occurred. Could not update"
      must_respond_with :success
    end
  end

  describe "destroy" do
    it "destroys the work instance in db when work exists, then redirects" do
      # Act-Assert
      expect {
        delete work_path(Work.first[:id])
      }.must_differ "Work.count", -1

      expect(flash[:success]).must_include "Successfully deleted"
      must_redirect_to works_path
    end

    it "does not change the db when the work does not exist, then responds with not found" do
      # Act-Assert
      expect {
        delete work_path(-1)
      }.must_differ "Work.count", 0

      expect(flash[:warning]).must_include "A problem occurred. This work does not exist"
      must_respond_with :not_found
    end
  end

end
