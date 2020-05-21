require "test_helper"

describe User do
  let (:new_user) {
    User.new(name: "test user")
  }
  it "can be instantiated" do
    # Assert
    expect(new_user.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_user.save
    user = User.first
    # Assert
    expect(user).must_respond_to :name
  end

  describe "validations" do
    it "must have a name" do
      # Arrange
      new_user.name = nil

      # Assert
      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :name
      expect(new_user.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "must have a unique title" do
      new_user.save
      another_user = User.create(name: "test user")

      expect(another_user.valid?).must_equal false
      expect(another_user.errors.messages).must_include :name
      expect(another_user.errors.messages[:name]).must_equal ["has already been taken"]
    end

  end

end
