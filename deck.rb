# frozen_string_literal: true

require_relative 'card'

class Deck
  attr_reader :cards

  NUMBERED_CARD_VALUE = [2, 3, 4, 5, 6, 7, 8, 9, 10].freeze
  PICTURED_CARD_VALUE = %w[J Q K A].freeze

  SUIT = { clubs: '+', diamonds: '<>', spades: '^', hearts: '<3' }.freeze

  def initialize
    @cards = []

    SUIT.each_key do |suit|
      NUMBERED_CARD_VALUE.each { |value| @cards << Card.new(value, suit) }
      PICTURED_CARD_VALUE.each { |value| @cards << Card.new(value, suit) }
    end

    @cards.shuffle!
  end

  def deal_card
    @cards.pop
  end
end
