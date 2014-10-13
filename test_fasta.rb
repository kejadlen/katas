require 'minitest/autorun'

require_relative 'dna'
require_relative 'fasta'

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

    assert_equal %w[Rosalind_6404 Rosalind_5959 Rosalind_0808], fasta.map(&:id)
    assert_equal <<-DNA.strip, fasta.find {|seq| seq.id == 'Rosalind_6404' }
CCTGCGGAAGATCGGCACTAGAATAGCCAGAACCGTTTCTCTGAGGCTTCCGGCCTTCCCTCCCACTAATAATTCTGAGG
    DNA
    assert_equal 'Rosalind_0808',
                 fasta.max_by {|seq| DNA.new(seq).gc_content }.id
  end

  def test_profile_matrix
    fasta = FASTA.new(<<-EOF)
>Rosalind_1
ATCCAGCT
>Rosalind_2
GGGCAACT
>Rosalind_3
ATGGATCT
>Rosalind_4
AAGCAACC
>Rosalind_5
TTGGAACT
>Rosalind_6
ATGCCATT
>Rosalind_7
ATGGCACT
    EOF
    profile_matrix = fasta.profile_matrix

    assert_equal({ ?A => 5, ?G => 1, ?T => 1 }, profile_matrix[0])
    assert_equal({ ?C => 1, ?T => 6 }, profile_matrix[7])
  end

  def test_consensus
    fasta = FASTA.new(<<-EOF)
>Rosalind_1
ATCCAGCT
>Rosalind_2
GGGCAACT
>Rosalind_3
ATGGATCT
>Rosalind_4
AAGCAACC
>Rosalind_5
TTGGAACT
>Rosalind_6
ATGCCATT
>Rosalind_7
ATGGCACT
    EOF

    assert_equal 'ATGCAACT', fasta.consensus
  end

  def test_adjacency_list
    fasta = FASTA.new(<<-EOF)
>Rosalind_0498
AAATAAA
>Rosalind_2391
AAATTTT
>Rosalind_2323
TTTTCCC
>Rosalind_0442
AAATCCC
>Rosalind_5013
GGGTGGG
    EOF

    assert_equal [ %w[ Rosalind_0498 Rosalind_2391 ],
                   %w[ Rosalind_0498 Rosalind_0442 ],
                   %w[ Rosalind_2391 Rosalind_2323 ] ],
    fasta.adjacency_list {|a,b| DNA.new(a).suffix(3) == DNA.new(b).prefix(3) }
  end

  def test_longest_common_substring
    fasta = FASTA.new(<<-EOF)
>Rosalind_1
GATTACA
>Rosalind_2
TAGACCA
>Rosalind_3
ATACA
    EOF

    assert_equal 'TA', fasta.longest_common_substring
  end
end
