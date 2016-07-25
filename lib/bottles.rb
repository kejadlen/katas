class Bottles
  def song
    verses(99, 0)
  end

  def verses(start, stop)
    start.downto(stop).map {|n| verse(n) }.join("\n")
  end

  def verse(n)
    Verse.new(n).to_s
  end

  class Verse
    DEFAULT_BEHAVIOR = {
      quantity: ->(n) { n },
      command: 'Take one down and pass it around',
      next: ->(n) { n - 1 },
    }
    BEHAVIORS = Hash.new({})
    BEHAVIORS[1] = { command: 'Take it down and pass it around' }
    BEHAVIORS[0] = { command: 'Go to the store and buy some more',
                     quantity: ->(_) { 'no more' },
                     next: ->(_) { 99 } }

    attr_reader :n

    def initialize(n)
      @n = n
    end

    def to_s
      <<-VERSE
#{refrain.capitalize}, #{descriptor}.
#{command}, #{succ.refrain}.
      VERSE
    end

    def refrain
      "#{descriptor} on the wall"
    end

    def descriptor
      "#{quantity} bottle#{?s if plural?} of beer"
    end

    private

    def command
      behaviors[:command]
    end

    def quantity
      behaviors[:quantity].call(n)
    end

    def behaviors
      DEFAULT_BEHAVIOR.merge(BEHAVIORS[n])
    end

    def plural?
      n != 1
    end

    def succ
      self.class.new(behaviors[:next].call(n))
    end
  end
end
