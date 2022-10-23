require 'rspec'
require './lib/card'
require './lib/deck'
require './lib/player'

RSpec.describe Player do
  it 'has cards and a deck' do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)
    deck = Deck.new([card1, card2, card3])

    expect(card1).to be_an_instance_of(Card)
    expect(deck).to be_an_instance_of(Deck)
  end

  it 'has a player with a deck' do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)
    deck = Deck.new([card1, card2, card3])
    player = Player.new('Clarisa', deck)
    # binding.pry
    expect(player).to be_an_instance_of(Player)
    expect(player.name).to eq('Clarisa')
    expect(player.deck).to eq(deck)
  end

  it 'has a player who has not lost by default' do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)
    deck = Deck.new([card1, card2, card3])
    player = Player.new('Clarisa', deck)

    expect(player.has_lost?).to eq(false)
  end

  it 'will lose if all cards are removed' do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)
    deck = Deck.new([card1, card2, card3])
    player = Player.new('Clarisa', deck)

    player.deck.remove_card
    player.deck.remove_card

    expect(player.has_lost?).to eq(false)

    player.deck.remove_card

    expect(player.has_lost?).to eq(true)
  end
end
