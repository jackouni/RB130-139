# Easy Challenges:

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

# Question 6: "Perfect Number"

## Test Cases:
```ruby
require 'minitest/autorun'
require_relative 'perfect_numbers'

class PerfectNumberTest < Minitest::Test
  def test_initialize_perfect_number
    assert_raises StandardError do
      PerfectNumber.classify(-1)
    end
  end

  def test_classify_deficient
    skip
    assert_equal 'deficient', PerfectNumber.classify(13)
  end

  def test_classify_perfect
    skip
    assert_equal 'perfect', PerfectNumber.classify(28)
  end

  def test_classify_abundant
    skip
    assert_equal 'abundant', PerfectNumber.classify(12)
  end
end
```

## Solution:
```ruby
class PerfectNumber
  def self.classify(num)
    raise StandardError if num < 1

    aliquot = (1..num-1).select { |div| num % div == 0 }
    
    case aliquot.sum
    when num   then "perfect"
    when num.. then "abundant"
    else "deficient"
    end
  end
end
```

---
---

# Question 7: "Octal"

## Test Cases:

```ruby
class OctalTest < Minitest::Test
  def test_octal_1_is_decimal_1
    assert_equal 1, Octal.new('1').to_decimal
  end

  def test_octal_10_is_decimal_8
    skip
    assert_equal 8, Octal.new('10').to_decimal
  end

  def test_octal_17_is_decimal_15
    skip
    assert_equal 15, Octal.new('17').to_decimal
  end

  def test_octal_11_is_decimal_9
    skip
    assert_equal 9, Octal.new('11').to_decimal
  end

  def test_octal_130_is_decimal_88
    skip
    assert_equal 88, Octal.new('130').to_decimal
  end

  def test_octal_2047_is_decimal_1063
    skip
    assert_equal 1063, Octal.new('2047').to_decimal
  end

  def test_octal_7777_is_decimal_4095
    skip
    assert_equal 4095, Octal.new('7777').to_decimal
  end

  def test_octal_1234567_is_decimal_342391
    skip
    assert_equal 342_391, Octal.new('1234567').to_decimal
  end

  def test_invalid_octal_is_decimal_0
    skip
    assert_equal 0, Octal.new('carrot').to_decimal
  end

  def test_8_is_seen_as_invalid_and_returns_0
    skip
    assert_equal 0, Octal.new('8').to_decimal
  end

  def test_9_is_seen_as_invalid_and_returns_0
    skip
    assert_equal 0, Octal.new('9').to_decimal
  end

  def test_6789_is_seen_as_invalid_and_returns_0
    skip
    assert_equal 0, Octal.new('6789').to_decimal
  end

  def test_abc1z_is_seen_as_invalid_and_returns_0
    skip
    assert_equal 0, Octal.new('abc1z').to_decimal
  end

  def test_valid_octal_formatted_string_011_is_decimal_9
    skip
    assert_equal 9, Octal.new('011').to_decimal
  end

  def test_234abc_is_seen_as_invalid_and_returns_0
    skip
    assert_equal 0, Octal.new('234abc').to_decimal
  end
end
```

## Solution:
```ruby
=begin  
P
  IP -> Integer (In Octal Number format)
  OP -> Integer (In Decimal Number format)

  Terms:
    Decimal:
      Each digit (starting from the rightmost) gets multipled by 10^n-1 (n representing the digits' index)
      Example:
        517
        5*10^2 + 1*10^1 + 7*10^0
        5*100  + 1*10   + 7*1
        500    + 10     + 7
        = 517

    Octal:
      Same as decimal except, instead of 10 we use 8
      Example
        517
        5*8^2 + 1*8^1 + 7*8^0
        5*64   + 1*8   + 7*1
        320    + 8     + 7
        = 327

    Rules:
      - IF input is 0 or anything else RETURN 0

DS
  IP Integer --> Array (of digits) --> Array (of digits to octal values)
  --> OP Integer (sum of ARray of octal values)

ALGO
  1. IF Input is 0 || anything else other than an Integer RETURN 0
  2. CONVERT input to Array of digits
  3. CONVERT each digit to octal value
  4. RETURN sum of octal values
=end

class Octal
  def initialize(num)
    @num = num
  end

  def to_decimal 
    return 0 unless valid_octal?
    digits = @num.to_i.digits
    digits.map.with_index { |digit, ind| digit * 8**ind }.sum
  end

  def valid_octal?
    @num.chars.all? { |char| char =~ /[0-7]/ }
  end
end
```

---
---

# Question 8: "Sum Of Multiples"

## Test Cases:
```ruby
require 'minitest/autorun'
require_relative 'sum_of_multiples'

class SumTest < Minitest::Test
  def test_sum_to_1
    assert_equal 0, SumOfMultiples.to(1)
  end

  def test_sum_to_3
    skip
    assert_equal 3, SumOfMultiples.to(4)
  end

  def test_sum_to_10
    skip
    assert_equal 23, SumOfMultiples.to(10)
  end

  def test_sum_to_100
    skip
    assert_equal 2_318, SumOfMultiples.to(100)
  end

  def test_sum_to_1000
    skip
    assert_equal 233_168, SumOfMultiples.to(1000)
  end

  def test_configurable_7_13_17_to_20
    skip
    assert_equal 51, SumOfMultiples.new(7, 13, 17).to(20)
  end

  def test_configurable_4_6_to_15
    skip
    assert_equal 30, SumOfMultiples.new(4, 6).to(15)
  end

  def test_configurable_5_6_8_to_150
    skip
    assert_equal 4419, SumOfMultiples.new(5, 6, 8).to(150)
  end

  def test_configurable_43_47_to_10000
    skip
    assert_equal 2_203_160, SumOfMultiples.new(43, 47).to(10_000)
  end
end
```

## Solution:
```ruby
=begin  
P
  IP -> Integer (Target Number), Integers (Sets of numbers)
  OP -> Integer (Sum of multiples of the set of numbers up to the target number)

  Terms & Rules:
    - IF there is no set of numbers given, use 3 & 5 as a default
    - NO duplicate multiples. Each multiple is unique

DS
  Target Integer --> Range (1..target-1) --> Array (Of numbers from range that are multiples of set numbers)
  --> Integer (sum of Array of multiples)

ALGO
  1. CREATE a Range from Target Number
  2. INIT multiples = []
  3. SELECT all multiples of set from Range
    **GO OVER each number in Range
      -- IF #any? number is a multiple of the set THEN add to multiples OR STORE
      -- ELSE GO NEXT
  4. IF multiples is empty RETURN 0
  5. ELSE RETURN sum of multiples
=end

class SumOfMultiples
  attr_reader :set

  def initialize(*set)
    @set = set.empty? ? [3, 5] : set
  end

  def self.to(target)
    SumOfMultiples.new.to(target)
  end

  def to(target)
    (1...target).select { |n| set.any? { |set_n| n % set_n == 0 } }.sum
  end
end
```

---
---

# Question 9: "Beer Song"

## Test Cases:
```ruby
require 'minitest/autorun'
require_relative 'beer_song'

# rubocop:disable Metrics/LineLength
class BeerSongTest < Minitest::Test
  def test_the_first_verse
    expected = "99 bottles of beer on the wall, 99 bottles of beer.\n" \
      "Take one down and pass it around, 98 bottles of beer on the wall.\n"
    assert_equal expected, BeerSong.verse(99)
  end

  def test_another_verse
    skip
    expected = "3 bottles of beer on the wall, 3 bottles of beer.\n" \
      "Take one down and pass it around, 2 bottles of beer on the wall.\n"
    assert_equal expected, BeerSong.verse(3)
  end

  def test_verse_2
    skip
    expected = "2 bottles of beer on the wall, 2 bottles of beer.\n" \
      "Take one down and pass it around, 1 bottle of beer on the wall.\n"
    assert_equal expected, BeerSong.verse(2)
  end

  def test_verse_1
    skip
    expected = "1 bottle of beer on the wall, 1 bottle of beer.\n" \
      "Take it down and pass it around, no more bottles of beer on the wall.\n"
    assert_equal expected, BeerSong.verse(1)
  end

  def test_verse_0
    skip
    expected = "No more bottles of beer on the wall, no more bottles of beer.\n" \
      "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
    assert_equal expected, BeerSong.verse(0)
  end

  def test_a_couple_verses
    skip
    expected = "99 bottles of beer on the wall, 99 bottles of beer.\n" \
      "Take one down and pass it around, 98 bottles of beer on the wall.\n" \
      "\n" \
      "98 bottles of beer on the wall, 98 bottles of beer.\n" \
      "Take one down and pass it around, 97 bottles of beer on the wall.\n"
    assert_equal expected, BeerSong.verses(99, 98)
  end

  def test_a_few_verses
    skip
    expected = "2 bottles of beer on the wall, 2 bottles of beer.\n" \
      "Take one down and pass it around, 1 bottle of beer on the wall.\n" \
      "\n" \
      "1 bottle of beer on the wall, 1 bottle of beer.\n" \
      "Take it down and pass it around, no more bottles of beer on the wall.\n" \
      "\n" \
      "No more bottles of beer on the wall, no more bottles of beer.\n" \
      "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
    assert_equal expected, BeerSong.verses(2, 0)
  end

  def test_the_whole_song # rubocop:disable Metrics/MethodLength
    skip
    expected = <<-SONG
99 bottles of beer on the wall, 99 bottles of beer.
Take one down and pass it around, 98 bottles of beer on the wall.

98 bottles of beer on the wall, 98 bottles of beer.
Take one down and pass it around, 97 bottles of beer on the wall.

97 bottles of beer on the wall, 97 bottles of beer.
Take one down and pass it around, 96 bottles of beer on the wall.

96 bottles of beer on the wall, 96 bottles of beer.
Take one down and pass it around, 95 bottles of beer on the wall.

95 bottles of beer on the wall, 95 bottles of beer.
Take one down and pass it around, 94 bottles of beer on the wall.

94 bottles of beer on the wall, 94 bottles of beer.
Take one down and pass it around, 93 bottles of beer on the wall.

93 bottles of beer on the wall, 93 bottles of beer.
Take one down and pass it around, 92 bottles of beer on the wall.

92 bottles of beer on the wall, 92 bottles of beer.
Take one down and pass it around, 91 bottles of beer on the wall.

91 bottles of beer on the wall, 91 bottles of beer.
Take one down and pass it around, 90 bottles of beer on the wall.

90 bottles of beer on the wall, 90 bottles of beer.
Take one down and pass it around, 89 bottles of beer on the wall.

89 bottles of beer on the wall, 89 bottles of beer.
Take one down and pass it around, 88 bottles of beer on the wall.

88 bottles of beer on the wall, 88 bottles of beer.
Take one down and pass it around, 87 bottles of beer on the wall.

87 bottles of beer on the wall, 87 bottles of beer.
Take one down and pass it around, 86 bottles of beer on the wall.

86 bottles of beer on the wall, 86 bottles of beer.
Take one down and pass it around, 85 bottles of beer on the wall.

85 bottles of beer on the wall, 85 bottles of beer.
Take one down and pass it around, 84 bottles of beer on the wall.

84 bottles of beer on the wall, 84 bottles of beer.
Take one down and pass it around, 83 bottles of beer on the wall.

83 bottles of beer on the wall, 83 bottles of beer.
Take one down and pass it around, 82 bottles of beer on the wall.

82 bottles of beer on the wall, 82 bottles of beer.
Take one down and pass it around, 81 bottles of beer on the wall.

81 bottles of beer on the wall, 81 bottles of beer.
Take one down and pass it around, 80 bottles of beer on the wall.

80 bottles of beer on the wall, 80 bottles of beer.
Take one down and pass it around, 79 bottles of beer on the wall.

79 bottles of beer on the wall, 79 bottles of beer.
Take one down and pass it around, 78 bottles of beer on the wall.

78 bottles of beer on the wall, 78 bottles of beer.
Take one down and pass it around, 77 bottles of beer on the wall.

77 bottles of beer on the wall, 77 bottles of beer.
Take one down and pass it around, 76 bottles of beer on the wall.

76 bottles of beer on the wall, 76 bottles of beer.
Take one down and pass it around, 75 bottles of beer on the wall.

75 bottles of beer on the wall, 75 bottles of beer.
Take one down and pass it around, 74 bottles of beer on the wall.

74 bottles of beer on the wall, 74 bottles of beer.
Take one down and pass it around, 73 bottles of beer on the wall.

73 bottles of beer on the wall, 73 bottles of beer.
Take one down and pass it around, 72 bottles of beer on the wall.

72 bottles of beer on the wall, 72 bottles of beer.
Take one down and pass it around, 71 bottles of beer on the wall.

71 bottles of beer on the wall, 71 bottles of beer.
Take one down and pass it around, 70 bottles of beer on the wall.

70 bottles of beer on the wall, 70 bottles of beer.
Take one down and pass it around, 69 bottles of beer on the wall.

69 bottles of beer on the wall, 69 bottles of beer.
Take one down and pass it around, 68 bottles of beer on the wall.

68 bottles of beer on the wall, 68 bottles of beer.
Take one down and pass it around, 67 bottles of beer on the wall.

67 bottles of beer on the wall, 67 bottles of beer.
Take one down and pass it around, 66 bottles of beer on the wall.

66 bottles of beer on the wall, 66 bottles of beer.
Take one down and pass it around, 65 bottles of beer on the wall.

65 bottles of beer on the wall, 65 bottles of beer.
Take one down and pass it around, 64 bottles of beer on the wall.

64 bottles of beer on the wall, 64 bottles of beer.
Take one down and pass it around, 63 bottles of beer on the wall.

63 bottles of beer on the wall, 63 bottles of beer.
Take one down and pass it around, 62 bottles of beer on the wall.

62 bottles of beer on the wall, 62 bottles of beer.
Take one down and pass it around, 61 bottles of beer on the wall.

61 bottles of beer on the wall, 61 bottles of beer.
Take one down and pass it around, 60 bottles of beer on the wall.

60 bottles of beer on the wall, 60 bottles of beer.
Take one down and pass it around, 59 bottles of beer on the wall.

59 bottles of beer on the wall, 59 bottles of beer.
Take one down and pass it around, 58 bottles of beer on the wall.

58 bottles of beer on the wall, 58 bottles of beer.
Take one down and pass it around, 57 bottles of beer on the wall.

57 bottles of beer on the wall, 57 bottles of beer.
Take one down and pass it around, 56 bottles of beer on the wall.

56 bottles of beer on the wall, 56 bottles of beer.
Take one down and pass it around, 55 bottles of beer on the wall.

55 bottles of beer on the wall, 55 bottles of beer.
Take one down and pass it around, 54 bottles of beer on the wall.

54 bottles of beer on the wall, 54 bottles of beer.
Take one down and pass it around, 53 bottles of beer on the wall.

53 bottles of beer on the wall, 53 bottles of beer.
Take one down and pass it around, 52 bottles of beer on the wall.

52 bottles of beer on the wall, 52 bottles of beer.
Take one down and pass it around, 51 bottles of beer on the wall.

51 bottles of beer on the wall, 51 bottles of beer.
Take one down and pass it around, 50 bottles of beer on the wall.

50 bottles of beer on the wall, 50 bottles of beer.
Take one down and pass it around, 49 bottles of beer on the wall.

49 bottles of beer on the wall, 49 bottles of beer.
Take one down and pass it around, 48 bottles of beer on the wall.

48 bottles of beer on the wall, 48 bottles of beer.
Take one down and pass it around, 47 bottles of beer on the wall.

47 bottles of beer on the wall, 47 bottles of beer.
Take one down and pass it around, 46 bottles of beer on the wall.

46 bottles of beer on the wall, 46 bottles of beer.
Take one down and pass it around, 45 bottles of beer on the wall.

45 bottles of beer on the wall, 45 bottles of beer.
Take one down and pass it around, 44 bottles of beer on the wall.

44 bottles of beer on the wall, 44 bottles of beer.
Take one down and pass it around, 43 bottles of beer on the wall.

43 bottles of beer on the wall, 43 bottles of beer.
Take one down and pass it around, 42 bottles of beer on the wall.

42 bottles of beer on the wall, 42 bottles of beer.
Take one down and pass it around, 41 bottles of beer on the wall.

41 bottles of beer on the wall, 41 bottles of beer.
Take one down and pass it around, 40 bottles of beer on the wall.

40 bottles of beer on the wall, 40 bottles of beer.
Take one down and pass it around, 39 bottles of beer on the wall.

39 bottles of beer on the wall, 39 bottles of beer.
Take one down and pass it around, 38 bottles of beer on the wall.

38 bottles of beer on the wall, 38 bottles of beer.
Take one down and pass it around, 37 bottles of beer on the wall.

37 bottles of beer on the wall, 37 bottles of beer.
Take one down and pass it around, 36 bottles of beer on the wall.

36 bottles of beer on the wall, 36 bottles of beer.
Take one down and pass it around, 35 bottles of beer on the wall.

35 bottles of beer on the wall, 35 bottles of beer.
Take one down and pass it around, 34 bottles of beer on the wall.

34 bottles of beer on the wall, 34 bottles of beer.
Take one down and pass it around, 33 bottles of beer on the wall.

33 bottles of beer on the wall, 33 bottles of beer.
Take one down and pass it around, 32 bottles of beer on the wall.

32 bottles of beer on the wall, 32 bottles of beer.
Take one down and pass it around, 31 bottles of beer on the wall.

31 bottles of beer on the wall, 31 bottles of beer.
Take one down and pass it around, 30 bottles of beer on the wall.

30 bottles of beer on the wall, 30 bottles of beer.
Take one down and pass it around, 29 bottles of beer on the wall.

29 bottles of beer on the wall, 29 bottles of beer.
Take one down and pass it around, 28 bottles of beer on the wall.

28 bottles of beer on the wall, 28 bottles of beer.
Take one down and pass it around, 27 bottles of beer on the wall.

27 bottles of beer on the wall, 27 bottles of beer.
Take one down and pass it around, 26 bottles of beer on the wall.

26 bottles of beer on the wall, 26 bottles of beer.
Take one down and pass it around, 25 bottles of beer on the wall.

25 bottles of beer on the wall, 25 bottles of beer.
Take one down and pass it around, 24 bottles of beer on the wall.

24 bottles of beer on the wall, 24 bottles of beer.
Take one down and pass it around, 23 bottles of beer on the wall.

23 bottles of beer on the wall, 23 bottles of beer.
Take one down and pass it around, 22 bottles of beer on the wall.

22 bottles of beer on the wall, 22 bottles of beer.
Take one down and pass it around, 21 bottles of beer on the wall.

21 bottles of beer on the wall, 21 bottles of beer.
Take one down and pass it around, 20 bottles of beer on the wall.

20 bottles of beer on the wall, 20 bottles of beer.
Take one down and pass it around, 19 bottles of beer on the wall.

19 bottles of beer on the wall, 19 bottles of beer.
Take one down and pass it around, 18 bottles of beer on the wall.

18 bottles of beer on the wall, 18 bottles of beer.
Take one down and pass it around, 17 bottles of beer on the wall.

17 bottles of beer on the wall, 17 bottles of beer.
Take one down and pass it around, 16 bottles of beer on the wall.

16 bottles of beer on the wall, 16 bottles of beer.
Take one down and pass it around, 15 bottles of beer on the wall.

15 bottles of beer on the wall, 15 bottles of beer.
Take one down and pass it around, 14 bottles of beer on the wall.

14 bottles of beer on the wall, 14 bottles of beer.
Take one down and pass it around, 13 bottles of beer on the wall.

13 bottles of beer on the wall, 13 bottles of beer.
Take one down and pass it around, 12 bottles of beer on the wall.

12 bottles of beer on the wall, 12 bottles of beer.
Take one down and pass it around, 11 bottles of beer on the wall.

11 bottles of beer on the wall, 11 bottles of beer.
Take one down and pass it around, 10 bottles of beer on the wall.

10 bottles of beer on the wall, 10 bottles of beer.
Take one down and pass it around, 9 bottles of beer on the wall.

9 bottles of beer on the wall, 9 bottles of beer.
Take one down and pass it around, 8 bottles of beer on the wall.

8 bottles of beer on the wall, 8 bottles of beer.
Take one down and pass it around, 7 bottles of beer on the wall.

7 bottles of beer on the wall, 7 bottles of beer.
Take one down and pass it around, 6 bottles of beer on the wall.

6 bottles of beer on the wall, 6 bottles of beer.
Take one down and pass it around, 5 bottles of beer on the wall.

5 bottles of beer on the wall, 5 bottles of beer.
Take one down and pass it around, 4 bottles of beer on the wall.

4 bottles of beer on the wall, 4 bottles of beer.
Take one down and pass it around, 3 bottles of beer on the wall.

3 bottles of beer on the wall, 3 bottles of beer.
Take one down and pass it around, 2 bottles of beer on the wall.

2 bottles of beer on the wall, 2 bottles of beer.
Take one down and pass it around, 1 bottle of beer on the wall.

1 bottle of beer on the wall, 1 bottle of beer.
Take it down and pass it around, no more bottles of beer on the wall.

No more bottles of beer on the wall, no more bottles of beer.
Go to the store and buy some more, 99 bottles of beer on the wall.
    SONG
    assert_equal expected, BeerSong.lyrics
  end
end
```

## Solution:
```ruby
=begin  
P
  IP -> Integer (number from "99 bottles of beer on the wall" to print), Integer (The number to decrement down to)
  OP -> String (Of the song in respective order counting fown from input)

  Terms/Rules:
    - The last bottle will display: "Take it down and pass it around, no more bottles of beer on the wall.\n"
    - IF the 1st or 2nd input is 0, display: "No more bottles of beer on the wall, no more bottles of beer.\n" \
                                  "Go to the store and buy some more, 99 bottles of beer on the wall.\n"

    - Default value for 2nd input is the 1st input's value
    - BeerSong::lyrics Returns the entire song, from 99 to 0

    - FORMAT:
      1) "#{first_input} bottles of beer on the wall, #{first_input} bottles of beer.\n" \
        "Take one down and pass it around, #{first_input - 1} bottles of beer on the wall.\n"

DS 
  Input Integer 1 --> Range (From Integer 2 to Integer 1) --> Array (Range reversed) --> Each Integer (From Array)

ALGO
  1. CONVERT Input 1 to Range from Input 2 to Input 1
  2. CONVERT Range to Array and Reverse it!
  3. STORE lyrics
    **GO OVER each number in Array
      **CONVERT current number into lyric
        -- IF number == 0 THEN STORE (no more bottles of beer lyrics)
        -- ELSE STORE as lyrics
  4. RETURN bottles of beer lyrics
=end

class BeerSong
  def self.verse(bottle_num)
    case bottle_num
    when 0
      "No more bottles of beer on the wall, no more bottles of beer.\n" \
      "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
    when 1
      "#{bottle_num} bottle of beer on the wall, #{bottle_num} bottle of beer.\n" \
      "Take it down and pass it around, no more bottles of beer on the wall.\n"
    when 2
      "#{bottle_num} bottles of beer on the wall, #{bottle_num} bottles of beer.\n" \
      "Take one down and pass it around, #{bottle_num - 1} bottle of beer on the wall.\n"
    else
      "#{bottle_num} bottles of beer on the wall, #{bottle_num} bottles of beer.\n" \
      "Take one down and pass it around, #{bottle_num - 1} bottles of beer on the wall.\n"
    end
  end

  def self.verses(starting_bottle, ending_bottle)
    lyrics_range = (ending_bottle..starting_bottle).to_a.reverse
    lyrics_range.map { |bottle_num| self.verse(bottle_num) }.join("\n")
  end

  def self.lyrics
    self.verses(99, 0)
  end
end
```

---
---

