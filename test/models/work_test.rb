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

  describe "relationships" do
    it "can have many votes" do
      # Arrange
      new_work.save
      new_user = User.create(name: "Kari")
      vote_1 = Vote.create(work_id: new_work.id, user_id: new_user.id)
      vote_2 = Vote.create(work_id: new_work.id, user_id: new_user.id)
      
      # Assert
      expect(new_work.votes.count).must_equal 2
      new_work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe "validations" do
    it "must have a title" do
      # Arrange
      new_work.title = nil

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "must have a unique title within its category" do
      new_work.save
      another_work = Work.create(title: "test work", category: "book")

      expect(another_work.valid?).must_equal false
      expect(another_work.errors.messages).must_include :title
      expect(another_work.errors.messages[:title]).must_equal ["has already been taken"]
    end

    it "can add the same title to a different category" do
      new_work.save
      another_work = Work.create(title: "test work", category: "movie")

      expect(another_work.valid?).must_equal true
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

  describe 'top work method' do
    it 'should return one work' do
      #Arrange
      one_work = Work.top_work

      #Assert
      expect(one_work).must_be_instance_of Work
    end

    it 'should return the work with most votes' do
      # Arrange
      new_work.save
      new_user = User.create(name: "Kari")
      vote_1 = Vote.create(work_id: new_work.id, user_id: new_user.id)
      vote_2 = Vote.create(work_id: new_work.id, user_id: new_user.id)

      work2 = Work.create(title: "another work", category: "book")

      # Assert
      expect(Work.top_work).must_equal new_work
    end
  end

  describe 'top ten method' do
    it 'should return an array' do
      #Arrange
      top_ten = Work.top_ten_works("movie")

      #Assert
      expect(top_ten).must_be_instance_of Array
    end

    it 'all works returned should belong to the same category' do
      #Arrange
      top_ten = Work.top_ten_works("movie")

      #Assert
      top_ten.each do |work|
        expect(work.category).must_equal "movie"
      end
    end

    it 'should return works in descending order by votes' do
      works = Work.where(category: "album")
      new_user = User.create(name: "Kari")

      works.each do |work|
        Vote.create(work_id: work.id, user_id: new_user.id)
      end

      vote_2 = Vote.create(work_id: works[1].id, user_id: new_user.id)
      top_ten = Work.top_ten_works("album")

      expect(top_ten.first.votes.count).must_equal 2
    end
  end
end
