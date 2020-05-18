require "test_helper"

describe Work do
  let (:new_work) {
    Work.new(title: "test work", category: "book")
  }
  it "can be instantiated" do
    # Assert
    expect(new_work.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_work.save
    work = Work.first
    [:title, :category].each do |field|

      # Assert
      expect(work).must_respond_to field
    end
  end

  # describe "relationships" do
  #   it "can have many votes" do
  #     # Arrange
  #     new_work.save
  #     new_user = User.create(name: "Kari")
  #     vote_1 = Vote.create(work_id: new_work.id, user_id: new_user.id)
  #     vote_2 = Vote.create(work_id: new_work.id, user_id: new_user.id)
  #     # Assert
  #     expect(new_work.votes.count).must_equal 2
  #     new_work.votes.each do |vote|
  #       expect(vote).must_be_instance_of Vote
  #     end
  #   end
  # end

  describe "validations" do
    it "must have a title" do
      # Arrange
      new_work.title = nil

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "must have a category" do
      # Arrange
      new_work.category = nil

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      expect(new_work.errors.messages[:category]).must_equal ["can't be blank"]
    end
  end

  # describe 'top work method' do
  #   it 'should return one work' do
  #     #Arrange
  #     one_work = Work.top_work

  #     #Assert
  #     expect(one_work).must_be_instance_of Work
  #   end
  # end

  # describe 'top ten method' do
  #   it 'should return an array of ten works' do
      
  #   end

  #   it 'should return all works if there are less than ten works' do
      
  #   end
  # end
end
