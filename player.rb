# frozen_string_literal: true

require_relative 'card'

class Player
  attr_accessor :bank, :hand
  attr_reader :name

  ACE_ELEVEN = 11
  ACE_ONE = 1

  def initialize(name)
    @name = name
    @bank = 100
    @hand = []
  end

  def make_bet
    @bank -= 10
  end

  def current_score
    sum = 0
    @hand.each { |card| sum += card.score unless card.value == 'A' }

    @hand.count { |card| card.value == 'A' }.times do
      sum += sum <= 10 ? ACE_ELEVEN : ACE_ONE
    end

    sum
  end

  def show_card_face
    @hand.map(&:to_s).join(' ')
  end

  def show_card_back
    @hand.map { '*' }.join(' ')
  end
end
