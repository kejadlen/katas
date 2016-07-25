class Bottles
  def verse(n)
    <<-VERSE
#{bottle_plural(n)} of beer on the wall, #{bottle_plural(n)} of beer.
#{second_line(n)}
    VERSE
  end

  def second_line(n)
    if n == 1
      'Take it down and pass it around, no more bottles of beer on the wall.'
    else
      "Take one down and pass it around, #{bottle_plural(n-1)} of beer on the wall."
    end
  end

  def bottle_plural(n)
    "#{n} bottle#{?s if n > 1}"
  end
end
