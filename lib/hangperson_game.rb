class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter)
    raise ArgumentError if !(letter =~ /^[a-zA-Z]/)
    letter.downcase!
    return false if (@guesses.include?(letter) || @wrong_guesses.include?(letter))
    if @word.include? letter
      @guesses += letter
    else
      @wrong_guesses += letter
    end
    return true
  end
  
  def word_with_guesses
    masked_word = ''
    @word.split("").each do |letter|
      #binding.pry
      if @guesses.include? letter
        masked_word += letter
      else
        masked_word += '-'
      end
    end
    return masked_word
  end
  
  def check_win_or_lose
    return :lose if wrong_guesses.length >= 7
    @word.split("").each do |letter|
      return :play if !(@guesses.include? letter)
    end
    return :win
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
