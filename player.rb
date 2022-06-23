require_relative 'card'

class Player
  attr_reader :name, :bank, :hand

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
    @hand.each { |card| sum += card.score unless card.value == "A" }

    @hand.count { |card| card.value == "A" }.times do
      sum += sum <= 10 ? 11 : 1
    end
    sum
  end

  def show_card_face
    @hand.map(&:to_s).join(' ')
  end

  def show_card_back
    @hand.map { "*" }.join(' ')
  end
end