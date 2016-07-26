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

  class Verse < SimpleDelegator
    def initialize(n)
      case n
      when 0
        super(Zero.new(n))
      when 1
        super(One.new(n))
      when 6
        super(Six.new(n))
      else
        super(Base.new(n))
      end
    end

    class Base
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
        "#{uber_quantity} of beer"
      end

      def uber_quantity
        "#{quantity} bottle#{?s if plural?}"
      end

      private

      def command
        'Take one down and pass it around'
      end

      def quantity
        n
      end

      def plural?
        n != 1
      end

      def succ
        Verse.new(n - 1)
      end
    end

    class Six < Base
      def uber_quantity
        '1 six-pack'
      end
    end

    class One < Base
      def command
        'Take it down and pass it around'
      end
    end

    class Zero < Base
      def command
        'Go to the store and buy some more'
      end

      def quantity
        'no more'
      end

      def succ
        Verse.new(99)
      end
    end
  end
end
