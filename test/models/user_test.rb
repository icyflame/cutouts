require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user can't be created without email" do
    a = User.new
    a.username = "test"
    assert_not a.save
  end

  test "user can't be created without username" do
    a = User.new
    a.email = "test@example.com"
    assert_not a.save
  end

  test "user can be created with just username and email" do
    a = User.new
    a.username = "test"
    a.email = "test@example.com"
  end

  test "user can't be created with a duplicate email ID" do
    a = User.new
    a.username = "test"
    a.email = "carson@downton.com"
    assert_not a.save
  end

  test "user can't be created with a duplicate username" do
    a = User.new
    a.username = "carson"
    a.email = "carons1@downton.com"
    assert_not a.save
  end

  test "user is associated with some articles" do
    carson = User.where({ :username => "carson" }).first
    assert_equal carson.articles.count, 2
  end
end
