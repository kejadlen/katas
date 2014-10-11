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
end

class TestFASTA < Minitest::Test
  def test_fasta
    fasta = FASTA.new(<<-EOF)
>Rosalind_6404
CCTGCGGAAGATCGGCACTAGAATAGCCAGAACCGTTTCTCTGAGGCTTCCGGCCTTCCC
TCCCACTAATAATTCTGAGG
>Rosalind_5959
CCATCGGTAGCGCATCCTTAGTCCAATTAAGTCCCTATCCAGGCGCTCCGCCGAAGGTCT
ATATCCATTTGTCAGCAGACACGC
>Rosalind_0808
CCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTTCAGACCAGCCCGGAC
TGGGAACCTGCGGGCAGTAGGTGGAAT
    EOF

    assert_equal %w[Rosalind_6404 Rosalind_5959 Rosalind_0808], fasta.dna.keys
    assert_equal DNA.new(<<-DNA), fasta.dna['Rosalind_6404']
CCTGCGGAAGATCGGCACTAGAATAGCCAGAACCGTTTCTCTGAGGCTTCCGGCCTTCCCTCCCACTAATAATTCTGAGG
    DNA
    assert_equal 'Rosalind_0808', fasta.dna.max_by {|_,v| v.gc_content }[0]
  end
end

class TestRNA < Minitest::Test
  def test_to_protein_string
    rna = RNA.new('AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGA')
    assert_equal 'MAMAPRTEINSTRING', rna.to_protein_string
  end
end
