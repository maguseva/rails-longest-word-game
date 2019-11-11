require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "visiting /new renders the 10 letters grid" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "getting error in case word isn't in grid" do
    visit new_url
    fill_in "word", with: "Hello"
    click_on "Play!"

    assert_text "Sorry, but HELLO can't be built from"
  end

  # TODO valid and non-valid english words
end
