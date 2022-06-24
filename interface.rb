class Interface
  MAX_CARDS_HAND = 3
  MAX_SCORE = 21
  DEALER_LIMIT = 17

  def start_game
    puts 'Добро пожаловать в игру BlackJack!'
    puts 'Введите ваше имя:'

    name = gets.chomp.to_s

    @player = Player.new(name)
    @dealer = Player.new('Дилер')
    @deck = Deck.new

    2.times { @player.hand << @deck.deal_cards }
    2.times { @dealer.hand << @deck.deal_cards }

    puts 'Идёт раздача карт...'
    sleep(3)

    @player.make_bet
    @dealer.make_bet

    puts 'Принимаются ставки...'
    sleep(3)

    player_turn
  end

  def player_turn
    winner if @player.hand.count == MAX_CARDS_HAND && @dealer.hand.count == MAX_CARDS_HAND

    puts "Ваши карты: #{@player.show_card_face}. Сумма очков: #{@player.current_score}."
    puts "Карты дилера: #{@dealer.show_card_back}"
    puts 'Ваш ход, что вы хотите сделать?'
    puts '1. Взять карту.'
    puts '2. Пропустить.'
    puts '3. Открыть карты.'

    input = gets.chomp.to_i

    case input
    when 1
      @player.hand << @deck.deal_cards unless @player.hand.count == MAX_CARDS_HAND

      puts 'Идёт раздача карт...'
      sleep(3)

      puts "Ваши карты: #{@player.show_card_face}. Сумма очков: #{@player.current_score}."
      puts 'Ход преходит к дилеру.'

      dealer_turn
    when 2
      puts 'Ход преходит к дилеру.'

      dealer_turn
    when 3
      winner
    end
  end

  def dealer_turn
    winner if @player.hand.count == MAX_CARDS_HAND && @dealer.hand.count == MAX_CARDS_HAND

    puts 'Дилер думает...'
    sleep(3)

    if @dealer.hand.count == 2 && @dealer.current_score < 17
      @dealer.hand << @deck.deal_cards

      puts 'Дилер берет карту...'
      sleep(3)

      player_turn
    elsif @dealer.hand.count == MAX_CARDS_HAND || @dealer.current_score >= 17
      puts 'Дилер пропускает.'

      player_turn
    end
  end

  def winner
    p1 = MAX_SCORE - @player.current_score
    p2 = MAX_SCORE - @dealer.current_score

    return draw if (p1 == p2) || (p1.negative? && p2.negative?)
    return @player if p2.negative?
    return @dealer if p1.negative?
    return @player if @player.current_score > @dealer.current_score

    @dealer

    game_results
  end

  def game_results
    puts "Ваши карты: #{@player.show_card_face}. Сумма очков: #{@player.current_score}."
    puts "Карты дилера: #{@dealer.show_card_face}. Cумма очков: #{@dealer.current_score}."

    if winner == @dealer
      winner.bank += 20
      puts "#{winner.name} победил!"
    elsif winner == @player
      winner.bank += 20
      puts "#{winner.name} победил!"
    elsif winner == draw
      @player.bank += 10
      @dealer.bank += 10
      puts 'Ничья!'
    end

    puts "#{@player}, хотите сыграть ещё раз?"
    puts '1. Да.'
    puts '2. Нет.'

    input = gets.chomp.to_i

    case input
    when 1
      next_round
    when 2
      puts "#{@player}, до новых встреч!"
      exit
    end
  end

  def next_round
    bank_check

    @deck = Deck.new

    2.times { @player.hand << @deck.deal_cards }
    2.times { @dealer.hand << @deck.deal_cards }

    puts 'Идёт раздача карт...'
    sleep(3)

    @player.make_bet
    @dealer.make_bet

    puts 'Принимаются ставки...'
    sleep(3)

    player_turn
  end

  def bank_check
    if @dealer.bank == 0
      puts 'Банк дилера опустел.'
      exit
    elsif @player.bank == 0
      puts "#{@player}, ваш банк пуст!"
      exit
    end
  end
end