include Enumerable

deck = { :"2H" => 2, :"3H" => 3, :"4H" => 4, :"5H" => 5, :"6H" => 6, :"7H" => 7, :"8H" => 8, :"9H" => 9, :"10H" => 10, :"JH" => 10, 
 :"QH" => 10, :"KH" => 10, :"AH" => 11, :"2D" => 2, :"3D" => 3, :"4D" => 4, :"5D" => 5, :"6D" => 6, :"7D" => 7, :"8D" => 8, :"9D" => 9, :"10D" => 10, :"JD" => 10, 
 :"QD" => 10, :"KD" => 10, :"AD" => 11, :"2S" => 2, :"3S" => 3, :"4S" => 4, :"5S" => 5, :"6S" => 6, :"7S" => 7, :"8S" => 8, :"9S" => 9, :"10S" => 10, :"JS" => 10, 
 :"QS" => 10, :"KS" => 10, :"AS" => 11, :"2C" => 2, :"3C" => 3, :"4C" => 4, :"5C" => 5, :"6C" => 6, :"7C" => 7, :"8C" => 8, :"9C" => 9, :"10C" => 10, :"JC" => 10, 
 :"QC" => 10, :"KC" => 10, :"AC" => 11}
 
 def deal_card(de) 
   a = de.to_a.flatten
   b = a.each_index.select {|i| i.even? }
   c = b.sample
   d = a[c]
   e = de[d]
   f = {}
   f[d] = e
   f
end

@player_card = {}
@dealer_card = {}


def add_player(card)
  card.each do |card, value|
    @player_card[card] = value
  end
end

def add_dealer(card)
  card.each do |card, value|
    @dealer_card[card] = value
  end
end

add_player(deal_card(deck))
add_player(deal_card(deck))
add_dealer(deal_card(deck))
add_dealer(deal_card(deck))

puts "What is your name?"
name = gets.chomp

puts "Welcome to Black Jack, #{name}"

puts "Shall we begin?"
ques = gets.chomp.upcase

if ques == "YES"
  puts "Dealing..."
  sleep 1
  puts "Dealer: H and #{@dealer_card.keys.last}"
  puts "#{name}: #{@player_card.keys.first} and #{@player_card.keys.last}"
else
  puts "Fine then go away!"
end

if @player_card.values.inject(:+) == 21
  puts "21! You win!"
  exit
else
  puts "Would you like to hit?"
end

ans = gets.chomp.upcase

if ans == "YES"
  add_player(deal_card(deck))
  puts "Dealer: Hidden and #{@dealer_card.keys.last}"
  puts "#{name}: #{@player_card.keys}"
  if @player_card.values.inject(:+) > 21
    if @player_card.values.include?(11)
      @player_card.select { |k, v| v == 11 ? @player_card[k] = 1 : @player_card[k] = v }
    else
    puts "Bust, you lose."
    exit
  end
  else
    puts "Would you like to hit again?"
    ans = gets.chomp.upcase
  end
end

puts "Dealer: #{@dealer_card.keys.first} and #{@dealer_card.keys.last}"
puts "#{name}: #{@player_card.keys}"

if @dealer_card.values.inject(:+) == 21
  puts "Dealer has 21 you lose!"
else
  while @dealer_card.values.inject(:+) < 17
    add_dealer(deal_card(deck))
    puts "Dealer: #{@dealer_card.keys}"
    puts "#{name}: #{@player_card.keys}"
    if @dealer_card.values.inject(:+) > 21
      if @dealer_card.values.include?(11)
        @dealer_card.select { |k, v| v == 11 ? @dealer_card[k] = 1 : @dealer_card[k] = v }
      else
      puts "Dealer busts. #{name} Wins!"
    end
    elsif @dealer_card.values.inject(:+) >= 17 && @dealer_card.values.inject(:+) > @player_card.values.inject(:+)
      puts "Dealer Wins."
    elsif @dealer_card.values.inject(:+) == @player_card.values.inject(:+)
      puts "Its a tie."
    elsif @dealer_card.values.inject(:+) >= 17 && @dealer_card.values.inject(:+) < @player_card.values.inject(:+)
      puts "#{name} Wins!"
    end
  end
end
