class Bottles
  def verse(n)
    <<-VERSE
#{n} bottles of beer on the wall, #{n} bottles of beer.
Take one down and pass it around, #{n-1} bottles of beer on the wall.
    VERSE
  end
end
