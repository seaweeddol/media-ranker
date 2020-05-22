require "test_helper"

describe Vote do
  describe "relationships" do
    it "can access its user" do
      # Arrange
      new_user = User.create(name: "test user")
      new_work = Work.create(title: "Test work", category: "movie")
      vote = Vote.create(work_id: new_work.id, user_id: new_user.id)
      
      # Assert
      expect(vote.user).must_equal new_user
      expect(vote.work).must_equal new_work
    end
  end
end
