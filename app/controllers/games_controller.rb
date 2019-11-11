require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
  end

  def uses_grid?(word, grid)
    letters = word.split('')
    letters.all? { |letter| letters.count(letter) <= grid.count(letter) }
  end

  def check_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = open(url).read
    JSON.parse(word_serialized)
  end

  def score
    @word = params['word'].upcase
    grid = params['letters']
    @result = { score: 0, message: "Sorry, but #{@word} can't be built from #{grid}" }
    if uses_grid?(@word, grid)
      if check_word(@word)['found']
        @result[:score] = check_word(@word)['length']
        @result[:message] = "Congratulations! #{@word} is a valid English word"
      else
        @result[:message] = "Sorry, but #{@word} doesn't seems to be a valid english word.."
      end
    end
    session[:score] = session[:score] ? session[:score] + @result[:score] : @result[:score]
  end
end
