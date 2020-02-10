require 'open-uri'
require 'json'

class ApplicationController < ActionController::Base
  def new
    o = [('A'..'Z')].map(&:to_a).flatten
    @letters = (0...10).map { o[rand(o.length)] }
  end

  def score
    @guess = params[:word]
    @letters = params[:letters]
    @include = included?(@guess, @letters)
    @english = english_word?(@guess)
  end

  def included?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

end
