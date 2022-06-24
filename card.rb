# frozen_string_literal: true

require_relative 'deck'

class Card
  attr_reader :value, :suit

  ACE_ELEVEN = 11
  ACE_ONE = 1
  PICTURES_VALUE = 10

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def score
    if Deck::NUMBERED_CARD_VALUE.include?(@value)
      @value
    elsif Deck::PICTURED_CARD_VALUE.include?(@value)
      PICTURES_VALUE
    end
  end

  def to_s
    "#{@value}#{Deck::SUIT[@suit]}"
  end
end
