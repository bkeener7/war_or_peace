class Turn
  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
    @turn_type = nil
  end

  def type
    if @player1.deck.rank_of_card_at(0) != @player2.deck.rank_of_card_at(0)
      @turn_type = :basic
    elsif @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0) && @player1.deck.cards.length < 3 || @player2.deck.cards.length < 3
      @turn_type = :loss
    elsif @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0) && @player1.deck.rank_of_card_at(2) == @player2.deck.rank_of_card_at(2)
      @turn_type = :mutually_assured_destruction
    elsif @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0)
      @turn_type = :war
    end
  end

  def winner
    case @turn_type
    when :mutually_assured_destruction
      'No Winner'
    when :war
      return @player1 if @player1.deck.rank_of_card_at(2) > @player2.deck.rank_of_card_at(2)

      @player2
    when :basic
      return @player1 if @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0)

      @player2
    when :loss
      return @player1 if @player1.deck.cards.length > @player2.deck.cards.length

      @player2
    end
  end

  def pile_cards
    case @turn_type
    when :mutually_assured_destruction
      players = [@player1, @player2]
      3.times do
        players.each do |card|
          card.deck.cards.shift
        end
      end
    when :war
      players = [@player1, @player2]
      3.times do
        players.each do |card|
          @spoils_of_war << card.deck.cards.shift
        end
      end
    when :basic
      players = [@player1, @player2]
      players.each do |card|
        @spoils_of_war << card.deck.cards.shift
      end
    end
  end

  def award_spoils_of_war(winner)
    if winner == 'No Winner'
    else
      (winner.deck.cards << @spoils_of_war.shuffle).flatten!
    end
    @spoils_of_war = []
  end
end
