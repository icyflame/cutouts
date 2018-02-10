require 'test_helper'

class ArticleControllerTest < ActionController::TestCase
  test "should not save article without link, author and quote" do
    a = Article.new
    assert_not a.save
  end

  test "should not save article without author and quote" do
    a = Article.new
    a.link = "http://example.com"
    assert_not a.save
  end

  test "should not save article without quote" do
    a = Article.new
    a.link = "http://example.com"
    a.author = "Amy Dunne"
    assert_not a.save
  end

  test "should save article with link, author and quote (bare minimum)" do
    a = Article.new
    a.link = "http://example.com"
    a.author = "Amy Dunne"
    a.quote = "We are so cute, I wanna punch us in the face"
    assert a.save
  end

  test "should not save article with invalid link" do
    a = Article.new
    a.link = "notalink"
    a.author = "Amy Dunne"
    a.quote = "We are so cute, I wanna punch us in the face"
    assert_not a.save
  end
end
