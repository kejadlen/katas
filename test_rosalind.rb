require 'minitest/autorun'

require_relative 'rosalind'

class Test < Minitest::Test
  def test_count_dna_nucleotides
    dna = 'AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC'
    assert_equal [20, 12, 17, 21], count_dna_nucleotides(dna)
  end

  def test_transcribe_dna_to_rna
    dna = 'GATGGAACTTGACTACGTAAATT'
    rna = 'GAUGGAACUUGACUACGUAAAUU'
    assert_equal rna, transcribe_dna_to_rna(dna)
  end
end
