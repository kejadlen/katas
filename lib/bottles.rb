class Bottles
  def verses(start, stop)
    start.downto(stop).map {|n| verse(n) }.join("\n")
  end

  def verse(n)
    <<-VERSE
#{bottle_plural(n).capitalize} of beer on the wall, #{bottle_plural(n)} of beer.
#{command(n)}, #{bottle_plural(next_quantity(n))} of beer on the wall.
    VERSE
  end

  def command(n)
    case n
    when 1
      'Take it down and pass it around'
    when 0
      'Go to the store and buy some more'
    else
      'Take one down and pass it around'
    end
  end

  def next_quantity(n)
    (n == 0) ? 99 : n - 1
  end

  def bottle_plural(n)
    "#{(n == 0) ? 'no more': n} bottle#{?s unless n == 1}"
  end
end
