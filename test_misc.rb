require 'minitest/autorun'

require_relative 'misc'

class TestMisc < Minitest::Test
  def test_rabbits
    assert_equal 1, Rabbits[[1, 3]]
    assert_equal 1, Rabbits[[2, 3]]
    assert_equal 4, Rabbits[[3, 3]]
    assert_equal 19, Rabbits[[5, 3]]
  end

  def test_mortal_rabbits
    assert_equal 1, MortalRabbits[[1, 3]]
    assert_equal 1, MortalRabbits[[2, 3]]
    assert_equal 2, MortalRabbits[[3, 3]]
    assert_equal 2, MortalRabbits[[4, 3]]
    assert_equal 3, MortalRabbits[[5, 3]]
    assert_equal 4, MortalRabbits[[6, 3]]
  end
end
