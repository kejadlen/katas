require 'minitest/autorun'

require_relative 'rosalind'

class TestDNA < Minitest::Test
  def test_nucleotide_count
    dna = DNA.new('AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC')
    assert_equal [20, 12, 17, 21], dna.nucleotide_count
  end

  def test_to_rna
    dna = DNA.new('GATGGAACTTGACTACGTAAATT')
    assert_equal 'GAUGGAACUUGACUACGUAAAUU', dna.to_rna
  end
end
