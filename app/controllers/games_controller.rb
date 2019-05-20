# frozen_string_literal: true

require 'json'
require 'open-uri'
# comment
class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('a'..'z').to_a.sample
    end
  end

  def include
    params[:word].split('').all? do |letter|
      params[:letters].split('').include?(letter)
    end
  end

  def parse
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    JSON.parse(URI.parse(url).open.read)
  end

  def score
    document_json = parse
    up = params[:word].upcase
    up_let = params[:letters].upcase
    if include == false
      @result = "Sorry but #{up} can't be built out of #{up_let}"
    elsif include == true && document_json['found'] == false
      @result = "Sorry but #{up} does not seem to be a valid English word..."
    elsif document_json['found'] == true
      @result = "Congratulations! #{up} is a valid English word!"
    end
  end
end
