require 'delegate'

class DNA < DelegateClass(String)
  attr_reader :raw

  def initialize(raw)
    super(raw.gsub(/[^acgt]/i, ''))
  end

  def nucleotide_count
    count = chars.each.with_object(Hash.new(0)) do |nucleotide, count|
      count[nucleotide] += 1
    end
    count.values_at(*%w[A C G T])
  end

  def to_rna
    tr(?T, ?U)
  end

  def reverse_complement
    reverse.tr('ATCG', 'TAGC')
  end

  def gc_content
    gc = chars.count {|nucleotide| nucleotide =~ /[GC]/i }
    100.0 * gc / length
  end

  def hamming_distance(dna)
    chars.zip(dna.chars).count {|a,b| a != b }
  end

  def suffix(n=3)
    self[-(n)..-1]
  end

  def prefix(n=3)
    self[0..(n-1)]
  end
end

class RNA
  CODONS = Hash[*<<-EOF.split(/\s+/)]
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
    Protein.new(
      raw.chars.each_slice(3)
        .map {|slice| CODONS[slice.join] }
        .take_while {|protein| protein != 'Stop' }
        .join
    )
  end
end

class Protein < DelegateClass(String)
  RNA_COUNT = RNA::CODONS.each.with_object(Hash.new(0)) {|(_,v),h| h[v] += 1 }

  def initialize(raw)
    super(raw.gsub(/\s+/, ''))
  end

  def motifs(motif)
    regex = motif_to_regex(motif)
    out = [ index(regex) ]
    until out.last.nil?
      out << index(regex, out.last + 1)
    end
    out.pop
    out.map {|i| i+1 }
  end

  def motif_to_regex(motif)
    Regexp.new(motif.gsub(/\{([^}])\}/, '[^\1]'))
  end

  def rna_count
    out = 1
    (chars + %w[ Stop ]).each do |char|
      out *= RNA_COUNT[char]
      out %= 1_000_000
    end
    out
  end
end
