# Easy 1 & 2

# Question 1:

## Test Cases Provided:
```ruby
# TEST CASES
require 'minitest/autorun'
require_relative 'triangles'

class TriangleTest < Minitest::Test
  def test_equilateral_equal_sides
    triangle = Triangle.new(2, 2, 2)
    assert_equal 'equilateral', triangle.kind
  end

  def test_larger_equilateral_equal_sides
    skip
    triangle = Triangle.new(10, 10, 10)
    assert_equal 'equilateral', triangle.kind
  end

  def test_isosceles_last_two_sides_equal
    skip
    triangle = Triangle.new(3, 4, 4)
    assert_equal 'isosceles', triangle.kind
  end

  def test_isosceles_first_last_sides_equal
    skip
    triangle = Triangle.new(4, 3, 4)
    assert_equal 'isosceles', triangle.kind
  end

  def test_isosceles_first_two_sides_equal
    skip
    triangle = Triangle.new(4, 4, 3)
    assert_equal 'isosceles', triangle.kind
  end

  def test_isosceles_exactly_two_sides_equal
    skip
    triangle = Triangle.new(10, 10, 2)
    assert_equal 'isosceles', triangle.kind
  end

  def test_scalene_no_equal_sides
    skip
    triangle = Triangle.new(3, 4, 5)
    assert_equal 'scalene', triangle.kind
  end

  def test_scalene_larger_no_equal_sides
    skip
    triangle = Triangle.new(10, 11, 12)
    assert_equal 'scalene', triangle.kind
  end

  def test_scalene_no_equal_sides_descending
    skip
    triangle = Triangle.new(5, 4, 2)
    assert_equal 'scalene', triangle.kind
  end

  def test_small_triangles_are_legal
    skip
    triangle = Triangle.new(0.4, 0.6, 0.3)
    assert_equal 'scalene', triangle.kind
  end

  def test_no_size_is_illegal
    skip
    assert_raises(ArgumentError) do
      triangle = Triangle.new(0, 0, 0)
    end
  end

  def test_negative_size_is_illegal
    skip
    assert_raises(ArgumentError) do
      triangle = Triangle.new(3, 4, -5)
    end
  end

  def test_size_inequality_is_illegal
    skip
    assert_raises(ArgumentError) do
      triangle = Triangle.new(1, 1, 3)
    end
  end

  def test_size_inequality_is_illegal_2
    skip
    assert_raises(ArgumentError) do
      triangle = Triangle.new(7, 3, 2)
    end
  end

  def test_size_inequality_is_illegal_3
    skip
    assert_raises(ArgumentError) do
      triangle = Triangle.new(10, 1, 3)
    end
  end

  def test_size_inequality_is_illegal_4
    skip
    assert_raises(ArgumentError) do
      triangle = Triangle.new(1, 1, 2)
    end
  end
end
```

## Solution:
```ruby
class Triangle 
  attr_reader :sides

  def initialize(s1, s2, s3)
    @sides = [s1, s2, s3]
    raise ArgumentError if sides.all? { |side| side <= 0 } 
    raise ArgumentError if invalid_sides?
  end

  def kind
    case unique_sides
    when 1 then 'equilateral'
    when 2 then 'isosceles'
    else 'scalene'
    end
  end

  private

  def invalid_sides?
    side_combos   = sides.combination(2).to_a
    sum_of_combos = side_combos.map(&:sum)

    sides.any? { |side| sum_of_combos.any? { |sum| side >= sum }}
  end

  def unique_sides
    sides.uniq.size
  end
end
```

---
---

# Question 2:

## Test Cases Provided:
```ruby
require 'minitest/autorun'
require_relative 'point_mutations'

class DNATest < Minitest::Test
  def test_no_difference_between_empty_strands
    assert_equal 0, DNA.new('').hamming_distance('')
  end

  def test_no_difference_between_identical_strands
    skip
    assert_equal 0, DNA.new('GGACTGA').hamming_distance('GGACTGA')
  end

  def test_complete_hamming_distance_in_small_strand
    skip
    assert_equal 3, DNA.new('ACT').hamming_distance('GGA')
  end

  def test_hamming_distance_in_off_by_one_strand
    skip
    strand = 'GGACGGATTCTGACCTGGACTAATTTTGGGG'
    distance = 'AGGACGGATTCTGACCTGGACTAATTTTGGGG'
    assert_equal 19, DNA.new(strand).hamming_distance(distance)
  end

  def test_small_hamming_distance_in_middle_somewhere
    skip
    assert_equal 1, DNA.new('GGACG').hamming_distance('GGTCG')
  end

  def test_larger_distance
    skip
    assert_equal 2, DNA.new('ACCAGGG').hamming_distance('ACTATGG')
  end

  def test_ignores_extra_length_on_other_strand_when_longer
    skip
    assert_equal 3, DNA.new('AAACTAGGGG').hamming_distance('AGGCTAGCGGTAGGAC')
  end

  def test_ignores_extra_length_on_original_strand_when_longer
    skip
    strand = 'GACTACGGACAGGGTAGGGAAT'
    distance = 'GACATCGCACACC'
    assert_equal 5, DNA.new(strand).hamming_distance(distance)
  end

  def test_does_not_actually_shorten_original_strand
    skip
    dna = DNA.new('AGACAACAGCCAGCCGCCGGATT')
    assert_equal 1, dna.hamming_distance('AGGCAA')
    assert_equal 4, dna.hamming_distance('AGACATCTTTCAGCCGCCGGATTAGGCAA')
    assert_equal 1, dna.hamming_distance('AGG')
  end
end
```

## Solution:
```ruby
class DNA 
  attr_reader :strand

  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(comparison_strand)
    differences = 0

    strand.chars.each_with_index do |point, ind|
      break if ind >= comparison_strand.size 
      differences += 1 unless point == comparison_strand[ind]
    end

    differences
  end
end
```

---
---

# Question 3:

## Test Cases Provided:
```ruby
require 'minitest/autorun'
require_relative 'roman_numerals'

class RomanNumeralsTest < Minitest::Test
  def test_1
    number = RomanNumeral.new(1)
    assert_equal 'I', number.to_roman
  end

  def test_2
    skip
    number = RomanNumeral.new(2)
    assert_equal 'II', number.to_roman
  end

  def test_3
    skip
    number = RomanNumeral.new(3)
    assert_equal 'III', number.to_roman
  end

  def test_4
    skip
    number = RomanNumeral.new(4)
    assert_equal 'IV', number.to_roman
  end

  def test_5
    skip
    number = RomanNumeral.new(5)
    assert_equal 'V', number.to_roman
  end

  def test_6
    skip
    number = RomanNumeral.new(6)
    assert_equal 'VI', number.to_roman
  end

  def test_9
    skip
    number = RomanNumeral.new(9)
    assert_equal 'IX', number.to_roman
  end

  def test_27
    skip
    number = RomanNumeral.new(27)
    assert_equal 'XXVII', number.to_roman
  end

  def test_48
    skip
    number = RomanNumeral.new(48)
    assert_equal 'XLVIII', number.to_roman
  end

  def test_59
    skip
    number = RomanNumeral.new(59)
    assert_equal 'LIX', number.to_roman
  end

  def test_93
    skip
    number = RomanNumeral.new(93)
    assert_equal 'XCIII', number.to_roman
  end

  def test_141
    skip
    number = RomanNumeral.new(141)
    assert_equal 'CXLI', number.to_roman
  end

  def test_163
    skip
    number = RomanNumeral.new(163)
    assert_equal 'CLXIII', number.to_roman
  end

  def test_402
    skip
    number = RomanNumeral.new(402)
    assert_equal 'CDII', number.to_roman
  end

  def test_575
    skip
    number = RomanNumeral.new(575)
    assert_equal 'DLXXV', number.to_roman
  end

  def test_911
    skip
    number = RomanNumeral.new(911)
    assert_equal 'CMXI', number.to_roman
  end

  def test_1024
    skip
    number = RomanNumeral.new(1024)
    assert_equal 'MXXIV', number.to_roman
  end

  def test_3000
    skip
    number = RomanNumeral.new(3000)
    assert_equal 'MMM', number.to_roman
  end
end
```

## Solution:
```ruby
class RomanNumeral
  attr_accessor :int

  ROMAN_TENS  = ['I', 'X', 'C', 'M']
  ROMAN_FIVES = ['V', 'L', 'D']

  def initialize(int)
    @int = int
  end

  def to_roman
    digits = int.digits
    digits.map.with_index do |digit, ind|
      case digit
      when 0    then ''
      when 1..3 then ROMAN_TENS[ind] * digit
      when 4    then ROMAN_TENS[ind] + ROMAN_FIVES[ind]
      when 5    then ROMAN_FIVES[ind]
      when 6..8 then ROMAN_FIVES[ind] + (ROMAN_TENS[ind] * (digit - 5))
      when 9    then ROMAN_TENS[ind] + ROMAN_TENS[ind+1]
      end
    end.reverse.join
  end
end
```

---
---
---
---

# Medium 1

# Question 1:

## Test Cases Provided:
```ruby
listener = Device.new
listener.listen { "Hello World!" }
listener.listen
listener.play # Outputs "Hello World!"
```

## Solution:
```ruby
class Device
  def initialize
    @recordings = []
  end

  def record(recording)
    @recordings << recording
  end

  def listen
    record(yield) if block_given?
  end

  def play
    @recordings.last
  end
end
```

---
---

# Question 2

## Test Cases
```ruby
analyzer = TextAnalyzer.new
analyzer.process { } # your implementation
analyzer.process { } # your implementation
analyzer.process { } # your implementation

# Should output something similar to (reference sample_text.txt):
# 3 paragraphs
# 15 lines
# 126 words
```

## Solution:
```ruby
class TextAnalyzer
  def initialize(path)
    @path = path
  end

  def process
    File.open(@path) { |file| yield(file) }
  end
end

analyzer = TextAnalyzer.new("sample_text.txt")
analyzer.process { |file| puts "#{file.readlines.count("\n") + 1} paragraphs" }
analyzer.process { |file| puts "#{file.readlines.size} lines" } 
analyzer.process { |file| puts "#{file.read.split.size} words" }
```

---
---

# Question 3: 

## Test Cases Provided:
```ruby
# Method should do: raven, finch, *raptors = %w(raven finch hawk eagle)
p raven    # => 'raven'
p finch    # => 'finch'
p raptors  # => ['hawk','eagle']
```

## Solution:
```ruby
# DESTRUCTURING WITHIN THE BLOCK:
def last_elements(arr)
  yield(arr)
end

birds = %w(raven finch hawk eagle)

hawk_and_eagle = last_elements(birds) { |_, _, *others| others }
hawk_and_eagle #=> ['hawk', 'eagle']

# OR YOU CAN DESTRUCTURE IN THE METHOD LIKE THIS:
def last_elements(arr)
  discard1, discard2, *keep = arr
  yield(keep)
end

birds = %w(raven finch hawk eagle)

hawk_and_eagle = last_elements(birds) { |prey| prey }
hawk_and_eagle #=> ['hawk', 'eagle']
```
