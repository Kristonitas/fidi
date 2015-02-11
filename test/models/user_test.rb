require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", password: "foobar",
                password_confirmation: "foobar")
  end

  test "name should be squished" do
    @user.name = "   John   Smith   "
    @user.save
    assert @user.name == "John Smith"
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

end
