require 'minitest/autorun'

require_relative 'misc'

class TestMisc < Minitest::Test
  include Rosalind

  def test_rabbits
    assert_equal 1, Rabbits[[1, 3]]
    assert_equal 1, Rabbits[[2, 3]]
    assert_equal 4, Rabbits[[3, 3]]
    assert_equal 19, Rabbits[[5, 3]]
  end

  def test_mortal_rabbits
    assert_equal [1, 0], MortalRabbits[[1, 3]]
    assert_equal [0, 1], MortalRabbits[[2, 3]]
    assert_equal [1, 1], MortalRabbits[[3, 3]]
    assert_equal [1, 1], MortalRabbits[[4, 3]]
    assert_equal [1, 2], MortalRabbits[[5, 3]]
    assert_equal [2, 2], MortalRabbits[[6, 3]]
  end

  def test_permutations
    assert_equal <<-EOF.split(/\s+/), Rosalind.permutations(%w[T A G C], 2)
TT TA TG TC AT AA AG AC GT GA GG GC CT CA CG CC
    EOF
  end

  def test_lexv
    assert_equal <<-EOF.split(/\s+/), Rosalind.lexv(%w[D N A], 3)
D DD DDD DDN DDA DN DND DNN DNA DA DAD DAN DAA
N ND NDD NDN NDA NN NND NNN NNA NA NAD NAN NAA
A AD ADD ADN ADA AN AND ANN ANA AA AAD AAN AAA
    EOF
  end

  def test_iprb
    assert_in_delta 0.783333, Rosalind.iprb(2, 2, 2), 0.001
  end
end
