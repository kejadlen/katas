require 'letters'
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

  def test_reverse_complement
    dna = DNA.new('AAAACCCGGT')
    assert_equal 'ACCGGGTTTT', dna.reverse_complement
  end

  def test_gc_content
    dna = DNA.new('CCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTTCAGACCAGCCCGGACTGGGAACCTGCGGGCAGTAGGTGGAAT')
    assert_in_delta 60.91954, dna.gc_content, 0.001
  end

  def hamming_distance
    a = DNA.new('GAGCCTACTAACGGGAT')
    b = DNA.new('CATCGTAATGACGGCCT')
    assert_equal 7, a.hamming_distance(b)
  end

  def test_suffix
    assert_equal 'AAA', DNA.new('AAATAAA').suffix
    assert_equal 'TTT', DNA.new('AAATTTT').suffix
  end

  def test_prefix
    assert_equal 'AAA', DNA.new('AAATAAA').prefix
    assert_equal 'AAA', DNA.new('AAATTTT').prefix
  end

  def test_open_reading_frames
    dna = DNA.new(<<-EOF)
AGCCATGTAGCTAACTCAGGTTACATGGGGATGACCCCGCGACTTGGATTAGAGTCTCTTTTGGAATAAGCCTGAATGAT
CCGAGTAGCATCTCAG
    EOF

    assert_equal %w[ MLLGSFRLIPKETLIQVAGSSPCNLS
                     M
                     MGMTPRLGLESLLE
                     MTPRLGLESLLE ].sort,
                 dna.to_proteins.sort
  end
end

class TestRNA < Minitest::Test
  def test_to_protein
    rna = RNA.new('AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGA')
    assert_equal 'MAMAPRTEINSTRING', rna.to_protein
  end

  def test_start_codon_indices
    rna = RNA.new('AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGA')

    assert_equal [ 0, 2 ], rna.start_codon_indices
  end

  def test_stop_codon_indices
    rna = RNA.new('AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGA')

    assert_equal [ 16 ], rna.stop_codon_indices
  end
end
