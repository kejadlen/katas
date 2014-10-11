class DNA
  attr_reader :raw

  def initialize(raw)
    @raw = raw.gsub(/[^acgt]/i, '')
  end

  def nucleotide_count
    count = raw.chars.each.with_object(Hash.new(0)) do |nucleotide, count|
      count[nucleotide] += 1
    end
    count.values_at(*%w[A C G T])
  end

  def to_rna
    raw.tr(?T, ?U)
  end

  def reverse_complement
    raw.reverse.tr('ATCG', 'TAGC')
  end

  def gc_content
    gc = raw.chars.count {|nucleotide| nucleotide =~ /[GC]/i }
    100.0 * gc / raw.length
  end

  def ==(dna)
    raw == dna.raw
  end

  def hamming_distance(dna)
    raw.chars.zip(dna.raw.chars).count {|a,b| a != b }
  end
end

class FASTA
  attr_reader :dna

  def initialize(raw)
    @dna = Hash[raw.scan(/>([^\n]+)\n([^>]+)\n/).map {|k,v| [k, DNA.new(v)] }]
  end
end

class RNA
  CODON_TABLE = Hash[*<<-EOF.split(/\s+/)]
UUU F      CUU L      AUU I      GUU V
UUC F      CUC L      AUC I      GUC V
UUA L      CUA L      AUA I      GUA V
UUG L      CUG L      AUG M      GUG V
UCU S      CCU P      ACU T      GCU A
UCC S      CCC P      ACC T      GCC A
UCA S      CCA P      ACA T      GCA A
UCG S      CCG P      ACG T      GCG A
UAU Y      CAU H      AAU N      GAU D
UAC Y      CAC H      AAC N      GAC D
UAA Stop   CAA Q      AAA K      GAA E
UAG Stop   CAG Q      AAG K      GAG E
UGU C      CGU R      AGU S      GGU G
UGC C      CGC R      AGC S      GGC G
UGA Stop   CGA R      AGA R      GGA G
UGG W      CGG R      AGG R      GGG G
  EOF

  attr_reader :raw

  def initialize(raw)
    @raw = raw.gsub(/[^acgu]/i, '')
  end

  def to_protein_string
    raw.chars.each_slice(3)
      .map {|slice| CODON_TABLE[slice.join] }
      .take_while {|protein| protein != 'Stop' }
      .join
  end
end
