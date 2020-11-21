require 'test_helper'
include ArticleHelper

class ArticleTest < ActiveSupport::TestCase
  test "should not save article without link and quote" do
    a = Article.new
    assert_not a.save
  end

  test "should not save article without quote" do
    a = Article.new
    a.link = "http://example.com"
    assert_not a.save
  end

  test "should not save article without link" do
    a = Article.new
    a.quote = "some quote"
    assert_not a.save
  end

  test "should save article with valid link and quote (bare minimum)" do
    a = Article.new
    a.link = "http://example.com"
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

  test "should not save article with link of length 256 chars" do
    a = Article.new
    link = "https://" + (1...249).map { |i| "a" }.join
    a.link = link
    a.author = "Amy Dunne"
    a.quote = "We are so cute, I wanna punch us in the face"
    assert_not a.save
  end

  test "should save article with link of length 255 chars" do
    a = Article.new
    link = "https://" + (1...248).map { |i| "a" }.join
    a.link = link
    a.author = "Amy Dunne"
    a.quote = "We are so cute, I wanna punch us in the face"
    assert a.save
  end

  test "should save article with valid, link, quote, author, tags as a public article" do
    a = Article.new
    a.link = "http://example.com"
    a.quote = "testing"
    a.author = "jack"
    a.tags = "test1, test2"

    assert a.valid?
    assert a.save

    assert_equal a.tags_array.count, 2
    assert_equal viz_int_val(a.visibility), 0
  end
end
