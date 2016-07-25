class Bottles
  def verse(n)
    <<-VERSE
#{bottle_plural(n)} of beer on the wall, #{bottle_plural(n)} of beer.
Take one down and pass it around, #{bottle_plural(n-1)} of beer on the wall.
    VERSE
  end

  def bottle_plural(n)
    "#{n} bottle#{?s if n > 1}"
  end
end
