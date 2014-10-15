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
    RNA.new(tr(?T, ?U))
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

  def reading_frames
    [self, reverse_complement].flat_map do |dna|
      (0..2).flat_map do |i|
        self.class.new(dna[i..-1])
      end
    end
  end

  def open_reading_frames
    reading_frames.flat_map do |frame|
      rna = frame.to_rna

      starts = rna.start_codon_indices
      stops = rna.stop_codon_indices

      starts.map {|start| [ start, stops.find {|stop| stop > start } ] }
            .reject {|_,stop| stop.nil? }
            .map {|start,stop| RNA.new(rna[(start*3)..((stop*3)+2)]) }
    end
  end

  def to_proteins
    open_reading_frames.map(&:to_protein).uniq
  end
end

class RNA < DelegateClass(String)
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

  START_CODON = 'AUG'
  STOP_CODONS = %w[ UAA UAG UGA ]

  attr_reader :codons

  def initialize(input)
    super(input.gsub(/[^acgu]/i, ''))

    @codons = chars.each_slice(3).map(&:join)
  end

  def to_protein
    raise unless codons[0] == START_CODON && STOP_CODONS.include?(codons[-1])

    Protein.new(codons.map {|codon| CODONS[codon] }[0..-2].join)
  end

  def start_codon_indices
    codons.each.with_object([]).with_index do |(codon,out),i|
      out << i if codon == START_CODON
    end
  end

  def stop_codon_indices
    codons.each.with_object([]).with_index do |(codon,out),i|
      out << i if STOP_CODONS.include?(codon)
    end
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

  def eql?(other)
    self == other
  end
end
