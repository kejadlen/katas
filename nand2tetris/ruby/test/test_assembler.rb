require 'minitest/autorun'

require 'assembler'

module Nand2Tetris::Assembler
  class TestParser < Minitest::Test
    def setup
      @parser = Parser.new
    end

    def test_comments
      tree = @parser.parse('  // Comments are cool')
      assert_equal [], tree

      tree = @parser.parse('// Multiple // Comments')
      assert_equal [], tree

      tree = @parser.parse(<<-INPUT)
// Multi
// Line
// Comments
      INPUT
      assert_equal [], tree

      tree = @parser.parse(' @0 // Foo bar baz')
      assert_equal [Node.new(:a_constant, 0)], tree

      tree = @parser.parse(' @0    ')
      assert_equal [Node.new(:a_constant, 0)], tree
    end

    def test_addresses
      tree = @parser.parse('@2')
      assert_equal [Node.new(:a_constant, 2)], tree

      tree = @parser.parse('@R2')
      assert_equal [Node.new(:a_symbol, 'R2')], tree
    end

    def test_computations
      tree = @parser.parse('D=A')
      assert_equal [Node.new(:c, [?D, ?A, ''])], tree

      tree = @parser.parse('D=D+A')
      assert_equal [Node.new(:c, [?D, 'D+A', ''])], tree

      tree = @parser.parse('M=D')
      assert_equal [Node.new(:c, [?M, ?D, ''])], tree

      tree = @parser.parse('D;JGT')
      assert_equal [Node.new(:c, ['', ?D, 'JGT'])], tree

      tree = @parser.parse('0;JMP')
      assert_equal [Node.new(:c, ['', ?0, 'JMP'])], tree
    end

    def test_labels
      tree = @parser.parse('(LOOP)')
      assert_equal [Node.new(:label, 'LOOP')], tree
    end

    def test_error
      assert_raises(ParseError) { @parser.parse('omg') }
      assert_raises(ParseError) { @parser.parse('@2R') }
    end
  end

  class TestTransformer < Minitest::Test
    def setup
      @transformer = Transformer.new
    end

    def test_addressing_constants
      tree = [Node.new(:a_constant, 2)]
      assert_equal '0000000000000010', @transformer.transform(tree)

      tree = [Node.new(:a_constant, 3)]
      assert_equal '0000000000000011', @transformer.transform(tree)

      tree = [Node.new(:a_constant, 0)]
      assert_equal '0000000000000000', @transformer.transform(tree)
    end

    def test_addressing_predefined_symbols
      tree = [Node.new(:a_symbol, 'R2')]
      assert_equal '0000000000000010', @transformer.transform(tree)
    end

    def test_addressing_variable_symbols
      tree = [
        Node.new(:a_symbol, 'foo'),
        Node.new(:a_symbol, 'bar'),
        Node.new(:a_symbol, 'baz'),
        Node.new(:a_symbol, 'foo'),
      ]
      assert_equal <<-EXPECTED.chomp, @transformer.transform(tree)
0000000000010000
0000000000010001
0000000000010010
0000000000010000
      EXPECTED
    end

    def test_computations
      tree = [Node.new(:c, [?D, ?A, ''])]
      assert_equal '1110110000010000', @transformer.transform(tree)

      tree = [Node.new(:c, [?D, 'D+A', ''])]
      assert_equal '1110000010010000', @transformer.transform(tree)

      tree = [Node.new(:c, [?M, ?D, ''])]
      assert_equal '1110001100001000', @transformer.transform(tree)

      tree = [Node.new(:c, ['', ?D, 'JGT'])]
      assert_equal '1110001100000001', @transformer.transform(tree)

      tree = [Node.new(:c, ['', ?0, 'JMP'])]
      assert_equal '1110101010000111', @transformer.transform(tree)
    end

    def test_labels
      tree = [
        Node.new(:label, 'FOO'),
        Node.new(:a_symbol, 'bar'),
        Node.new(:label, 'LOOP'),
        Node.new(:a_symbol, 'FOO'),
        Node.new(:a_symbol, 'LOOP'),
      ]
      assert_equal <<-EXPECTED.chomp, @transformer.transform(tree)
0000000000010000
0000000000000000
0000000000000001
      EXPECTED
    end

    def test_error
      assert_raises(TransformError) { @transformer.transform([Node.new(:b, 'omg')]) }
    end
  end
end
