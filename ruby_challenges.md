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

# Question 10: "Series"

## Test Cases:
```ruby
require 'minitest/autorun'
require_relative 'series'

class SeriesTest < Minitest::Test
  def test_simple_slices_of_one
    series = Series.new('01234')
    assert_equal [[0], [1], [2], [3], [4]], series.slices(1)
  end

  def test_simple_slices_of_one_again
    skip
    series = Series.new('92834')
    assert_equal [[9], [2], [8], [3], [4]], series.slices(1)
  end

  def test_simple_slices_of_two
    skip
    series = Series.new('01234')
    assert_equal [[0, 1], [1, 2], [2, 3], [3, 4]], series.slices(2)
  end

  def test_other_slices_of_two
    skip
    series = Series.new('98273463')
    expected = [[9, 8], [8, 2], [2, 7], [7, 3], [3, 4], [4, 6], [6, 3]]
    assert_equal expected, series.slices(2)
  end

  def test_simple_slices_of_two_again
    skip
    series = Series.new('37103')
    assert_equal [[3, 7], [7, 1], [1, 0], [0, 3]], series.slices(2)
  end

  def test_simple_slices_of_three
    skip
    series = Series.new('01234')
    assert_equal [[0, 1, 2], [1, 2, 3], [2, 3, 4]], series.slices(3)
  end

  def test_simple_slices_of_three_again
    skip
    series = Series.new('31001')
    assert_equal [[3, 1, 0], [1, 0, 0], [0, 0, 1]], series.slices(3)
  end

  def test_other_slices_of_three
    skip
    series = Series.new('982347')
    expected = [[9, 8, 2], [8, 2, 3], [2, 3, 4], [3, 4, 7]]
    assert_equal expected, series.slices(3)
  end

  def test_simple_slices_of_four
    skip
    series = Series.new('01234')
    assert_equal [[0, 1, 2, 3], [1, 2, 3, 4]], series.slices(4)
  end

  def test_simple_slices_of_four_again
    skip
    series = Series.new('91274')
    assert_equal [[9, 1, 2, 7], [1, 2, 7, 4]], series.slices(4)
  end

  def test_simple_slices_of_five
    skip
    series = Series.new('01234')
    assert_equal [[0, 1, 2, 3, 4]], series.slices(5)
  end

  def test_simple_slices_of_five_again
    skip
    series = Series.new('81228')
    assert_equal [[8, 1, 2, 2, 8]], series.slices(5)
  end

  def test_simple_slice_that_blows_up
    skip
    series = Series.new('01234')
    assert_raises ArgumentError do
      series.slices(6)
    end
  end

  def test_more_complicated_slice_that_blows_up
    skip
    slice_string = '01032987583'

    series = Series.new(slice_string)
    assert_raises ArgumentError do
      series.slices(slice_string.length + 1)
    end
  end
end
```

## Solutions:
```ruby
=begin  
P
  IP -> String (of digits) ; Integer (the number of consecutive digits from String to retrieve)
  OP -> 2D Array (Subarrys of all consecutive digits of the Input Integer length, from the input String)

  Terms:
    - Throw an ArgumentError if the Integer input is greater than the length of the String of digits
    - Numbers do not need to be in numerical order, just consecutive in their order in the input String
    - NO TEST CASE: for non-numerical digits in input String

DS
  Input String --> Array (of chars) --> Array (individual digits) --> Output 2D Array (of consecutive digits)

ALGO
** n == input integer

  0.5 THROW ERROR if n > input String size
  1. CONVERT input String into Array of digits
  2. GET Consecutive slices from Array of digits
    **GO OVER each index of digits up to [digits.size - n]
      -- BREAK IF index == n (digits.size - n)
      -- STORE slice from current index to: n number of elements || current index  + (n-1)
  3. RETURN stored 2D Array of slices
=end

# SOLUTION #1:
class Series
  def initialize(nums)
    @nums = nums
  end

  def slices(n)
    raise ArgumentError if n > @nums.size
    digits = @nums.chars.map(&:to_i)
    digits.each_cons(n).to_a
  end
end

# SOLUTION #2:
class Series
  def initialize(nums)
    @nums = nums
  end

  def slices(n)
    raise ArgumentError if n > @nums.size
    digits = @nums.chars.map(&:to_i)

    digits.map.with_index do |_, ind|
      ind > @nums.size - n ? nil : digits[ind, n]
    end.compact
  end
end 

# SOLUTION #3 (manual iteration):
class Series
  def initialize(nums)
    @nums = nums
  end

  def slices(n)
    raise ArgumentError if n > @nums.size
    counter = 0
    consecutives = []

    while counter <= @nums.size - n do
      slice = @nums[counter, n].chars
      consecutives << slice.map(&:to_i)
      counter += 1
    end

    consecutives
  end

  # SOLUTION #4:
  class Series
    def initialize(nums)
      @nums = nums.chars.map(&:to_i)
    end

    def slices(n)
      raise ArgumentError if n > @nums.size
      @nums.each_cons(n).to_a
    end
  end 
```

---
---
---
---

# Medium Challenges:

## Question 1: "Diamond"

## Test Cases:
```ruby
require 'minitest/autorun'
require_relative '10_diamond'

class DiamondTest < Minitest::Test
  def test_letter_a
    answer = Diamond.make_diamond('A')
    assert_equal "A\n", answer
  end

  def test_letter_b
    skip
    answer = Diamond.make_diamond('B')
    assert_equal " A \nB B\n A \n", answer
  end

  def test_letter_c
    skip
    answer = Diamond.make_diamond('C')
    string = "  A  \n"\
             " B B \n"\
             "C   C\n"\
             " B B \n"\
             "  A  \n"
    assert_equal string, answer
  end

  def test_letter_e
    skip
    answer = Diamond.make_diamond('E')
    string = "    A    \n"\
             "   B B   \n"\
             "  C   C  \n"\
             " D     D \n"\
             "E       E\n"\
             " D     D \n"\
             "  C   C  \n"\
             "   B B   \n"\
             "    A    \n"
    assert_equal string, answer
  end
end
```

## Solution:
```ruby
=begin  
P
  IP -> String (A single letter)
  OP -> String (of letters printed starting from A and ending in A)

  Terms:
    - The first row contains one 'A'.
    - The last row contains one 'A'.
    - All rows, except the first and last, have exactly two identical letters.
    - The diamond is horizontally symmetric.
    - The diamond is vertically symmetric.
    - The diamond has a square shape (width equals height).
    - The letters form a diamond shape.
    - The top half has the letters in ascending order.
    - The bottom half has the letters in descending order.
    - The four corners (containing the spaces) are triangles.

    - IF input letter is 'A' Return "A\n"

DS
  * Input String 
  * Array (of upcased letters)

ALGO

  Diamond Rules:
    A      -- 0 Spaces middle  ; 4 Spaces sides ; 1 letter  ; ind 0
   B B     -- 1 Space middle   ; 3 Spaces sides ; 2 letters ; ind 1
  C   C    -- 3 Spaces middle  ; 2 Spaces sides ; 2 letters ; ind 2 
 D     D   -- 5 Spaces middle  ; 1 Spaces sides ; 2 letters ; ind 3
E       E  -- 7 Spaces middle  ; 0 Spaces sides ; 2 letters ; ind 4
          1. Middle spaces == ind + previous ind
          2. Side spaces   == last ind - ind

 D     D  3. Reverse: (First half - last line) 
  C   C
   B B
    A
          
  Steps:
  ** INIT results = []
  1. GET index of input letter
  2. GET ALPHABET slice from 'A' to index of input letter
  
  4. GO OVER each letter with index of slice
    a) GET middle_spaces
    -- IF letter == 'A' THEN 0
    ELSE current ind + (current ind-1)
    b) GET side spaces
    -- last ind - current ind
    c) STORE formatted String in results
    -- side spaces + current letter + middle spaces + current letter + side spaces
  
  5. IF input letter is 'A' THEN RETURN "A\n"

  6. GET second half of results 
    -- GET results slice from First to 2nd last element
    -- CONVERT results slice to be reversed
    -- STORE reversed results slice

  7. RETURN results joined
=end

class Diamond
  def self.make_diamond(last_letter)
    return "A\n" if last_letter == 'A'

    letters  = ('A'..last_letter).to_a
    
    top_half     = Diamond.top_half(letters)
    bottom_half  = top_half[0...-1].reverse 
    full_diamond = top_half + bottom_half
    full_diamond.join
  end

  private

  def self.middle_spaces(ind)
    return "" if ind.zero? 
    " " * (ind * 2 - 1)
  end
  
  def self.side_spaces(ind, last_ind)
    " " * (last_ind - ind)
  end

  def self.top_half(letters)
    last_ind = letters.size - 1

    letters.map.with_index do |letter, ind|
      middle_spaces  = Diamond.middle_spaces(ind)
      side_spaces    = Diamond.side_spaces(ind, last_ind)

      if letter == 'A'
        side_spaces + letter + side_spaces + "\n"
      else 
        side_spaces + letter + middle_spaces + letter + side_spaces + "\n"
      end
    end
  end
end
```

---
---

# Question 2: "Robot Name":

## Test Cases:
```ruby
require 'minitest/autorun'
require_relative 'robot_name'

class RobotTest < Minitest::Test
  DIFFERENT_ROBOT_NAME_SEED = 1234
  SAME_INITIAL_ROBOT_NAME_SEED = 1000

  NAME_REGEXP = /^[A-Z]{2}\d{3}$/

  def test_has_name
    assert_match NAME_REGEXP, Robot.new.name
  end

  def test_name_sticks
    skip
    robot = Robot.new
    robot.name
    assert_equal robot.name, robot.name
  end

  def test_different_robots_have_different_names
    skip
    Kernel.srand DIFFERENT_ROBOT_NAME_SEED
    refute_equal Robot.new.name, Robot.new.name
  end

  def test_reset_name
    skip
    Kernel.srand DIFFERENT_ROBOT_NAME_SEED
    robot = Robot.new
    name = robot.name
    robot.reset
    name2 = robot.name
    refute_equal name, name2
    assert_match NAME_REGEXP, name2
  end

  def test_different_name_when_chosen_name_is_taken
    skip
    Kernel.srand SAME_INITIAL_ROBOT_NAME_SEED
    name1 = Robot.new.name
    Kernel.srand SAME_INITIAL_ROBOT_NAME_SEED
    name2 = Robot.new.name
    refute_equal name1, name2
  end
end
```

## Solution:
```ruby
=begin  
P
  IP --> Robot.new (instantiation of a Robot creates a unique random name)
  OP --> String (random name)

  Terms:
    - Robot#name returns Robot's @name
    - Robot#reset resets the Robot's @name to a NEW/UNIQUE name
    - Every time a new Robot is instantiated it is given a random name. This is a unique name that should not be the same name as
    another Robot.

    Rules for naming:
      1. Must be unique to other names created for all other Robots (class var?)
      2. Must start with 2 uppercase letters, followed by 3 digits (0-9)

ALGO
  ** INIT @@names
  1. Instantiating a new Robot with name:
    a) LOOP until unique name is made:
      -- GET random 2 upcase letters
      -- GET random 3 digits
      -- CONCATENATE random letters with digits to get a random_name
      -- IF @@names **does not** include random_name THEN BREAK

    b) SET @name = random_name
    c) PUSH random_name to @@names

  2. Robot#reset
      a) LOOP until unique name is made:
        -- GET random 2 upcase letters
        -- GET random 3 digits
        -- CONCATENATE random letters with digits to get a random_name
        -- IF @@names **does not** include random_name THEN BREAK

      b) SET @name = random_name 
=end

class Robot
  LETTERS = ('A'..'Z').to_a
  NUMBERS = ('0'..'9').to_a
  @@taken_names = []

  def name
    return @name if @name
    @name = generate_name
  end

  def reset
    @@taken_names.delete(@name)
    @name = nil
  end

  private
  
  def generate_name
    random_name = ''

    loop do
      random_letters = ''
      2.times { random_letters << LETTERS.sample }
    
      random_numbers = ''
      3.times { random_numbers << NUMBERS.sample }
    
      random_name = random_letters + random_numbers
      break unless @@taken_names.include?(random_name)
    end

    @@taken_names << random_name
    random_name
  end
end
```

---
---

# Question 3: "Clock"

## Test Cases:
```ruby
require 'minitest/autorun'
require_relative 'clock'

class ClockTest < Minitest::Test
  def test_on_the_hour
    assert_equal '08:00', Clock.at(8).to_s
    assert_equal '09:00', Clock.at(9).to_s
  end

  def test_past_the_hour
    skip
    assert_equal '11:09', Clock.at(11, 9).to_s
  end

  def test_add_a_few_minutes
    skip
    clock = Clock.at(10) + 3
    assert_equal '10:03', clock.to_s
  end

  def test_adding_does_not_mutate
    skip
    old_clock = Clock.at(10)
    new_clock = old_clock + 3
    refute_same new_clock, old_clock
  end

  def test_subtract_fifty_minutes
    skip
    clock = Clock.at(0) - 50
    assert_equal '23:10', clock.to_s
  end

  def test_subtracting_does_not_mutate
    skip
    old_clock = Clock.at(10)
    new_clock = old_clock - 50
    refute_same new_clock, old_clock
  end

  def test_add_over_an_hour
    skip
    clock = Clock.at(10) + 61
    assert_equal '11:01', clock.to_s
  end

  def test_wrap_around_at_midnight
    skip
    clock = Clock.at(23, 30) + 60
    assert_equal '00:30', clock.to_s
  end

  def test_add_more_than_a_day
    skip
    clock = Clock.at(10) + 3061
    assert_equal '13:01', clock.to_s
  end

  def test_subtract_a_few_minutes
    skip
    clock = Clock.at(10, 30) - 5
    assert_equal '10:25', clock.to_s
  end

  def test_subtract_minutes
    skip
    clock = Clock.at(10) - 90
    assert_equal '08:30', clock.to_s
  end

  def test_wrap_around_at_negative_midnight
    skip
    clock = Clock.at(0, 30) - 60
    assert_equal '23:30', clock.to_s
  end

  def test_subtract_more_than_a_day
    skip
    clock = Clock.at(10) - 3061
    assert_equal '06:59', clock.to_s
  end

  def test_equivalent_clocks
    skip
    clock1 = Clock.at(15, 37)
    clock2 = Clock.at(15, 37)
    assert_equal clock1, clock2
  end

  def test_inequivalent_clocks
    skip
    clock1 = Clock.at(15, 37)
    clock2 = Clock.at(15, 36)
    clock3 = Clock.at(14, 37)
    refute_equal clock1, clock2
    refute_equal clock1, clock3
  end

  def test_wrap_around_backwards
    skip
    clock1 = Clock.at(0, 30) - 60
    clock2 = Clock.at(23, 30)
    assert_equal clock1, clock2
  end
end
```

## Solution:
```ruby
class Clock
  HOURS   = (0..23).map { |hr|  "%02d" % hr }
  MINUTES = (0..59).map { |min| "%02d" % min }
  MINUTES_IN_HOUR = 60
  HOURS_IN_DAY    = 24

  attr_reader :hour, :minute

  def initialize(hour, minute)
    @hour = hour
    @minute = minute
  end

  def self.at(hour, minute=0)
    Clock.new(hour, minute)
  end

  def to_s
    HOURS[hour] + ":" + MINUTES[minute]
  end

  def +(minutes)
    new_hour   = minutes_to_hours(minutes)           
    new_minute = minute + remainder_minutes(minutes)

    new_hour += hour

    if minute_wraps?(new_minute)
      new_hour += 1
      new_minute = remainder_minutes(new_minute)
    end

    new_hour %= 24 if hour_wraps?(new_hour)

    Clock.at(new_hour, new_minute)
  end


  def -(minutes)
    new_hour   = hour - minutes_to_hours(minutes)   
    new_minute = minute - remainder_minutes(minutes)

    if minute_wraps?(new_minute)
      new_hour -= 1 
      new_minute = 60 - remainder_minutes(new_minute.abs)
    end

    if hour_wraps?(new_hour)
      new_hour = 24 - remainder_hours(new_hour.abs) 
    end

    Clock.at(new_hour, new_minute)
  end

  def ==(other_clock)
    to_s == other_clock.to_s
  end

  private 

  def minutes_to_hours(minutes)
    minutes / MINUTES_IN_HOUR
  end

  def remainder_minutes(minutes)
    minutes % MINUTES_IN_HOUR
  end

  def remainder_hours(hours)
    hours % HOURS_IN_DAY
  end

  def minute_wraps?(minutes)
    minutes > 59 || minutes < 0
  end

  def hour_wraps?(hours)
    hours > 23 || hours < 0
  end
end
```

---
---

# Question 6: "Custom Sets"

## Test Cases:
```ruby
require 'minitest/autorun'
require_relative 'custom_set'

class CustomSetTest < Minitest::Test
  def test_empty
    assert_equal true, CustomSet.new.empty?
  end

  def test_not_empty
    skip
    set = CustomSet.new([1])
    assert_equal false, set.empty?
  end

  def test_empty_does_not_contain
    skip
    set = CustomSet.new
    assert_equal false, set.contains?(1)
  end

  def test_does_contain
    skip
    set = CustomSet.new([1, 2, 3])
    assert_equal true, set.contains?(1)
  end

  def test_set_does_not_contain
    skip
    set = CustomSet.new([1, 2, 3])
    assert_equal false, set.contains?(4)
  end

  def test_subset_empty
    skip
    empty_set = CustomSet.new
    assert_equal true, empty_set.subset?(CustomSet.new)
  end

  def test_empty_is_subset_of_non_empty
    skip
    empty_set = CustomSet.new
    assert_equal true, empty_set.subset?(CustomSet.new([1]))
  end

  def test_non_empty_not_subset_of_empty
    skip
    set = CustomSet.new([1])
    assert_equal false, set.subset?(CustomSet.new)
  end

  def test_set_is_subset_of_same_set_of_elements
    skip
    set = CustomSet.new([1, 2, 3])
    assert_equal true, set.subset?(CustomSet.new([1, 2, 3]))
  end

  def test_set_is_subset_of_larger_set
    skip
    set = CustomSet.new([1, 2, 3])
    assert_equal true, set.subset?(CustomSet.new([4, 1, 2, 3]))
  end

  def test_not_subset_when_different_elements
    skip
    set = CustomSet.new([1, 2, 3])
    assert_equal false, set.subset?(CustomSet.new([4, 1, 3]))
  end

  def test_disjoint_empty_set
    skip
    empty_set = CustomSet.new
    assert_equal true, empty_set.disjoint?(CustomSet.new)
  end

  def test_disjoint_empty_and_non_empty
    skip
    empty_set = CustomSet.new
    assert_equal true, empty_set.disjoint?(CustomSet.new([1]))
  end

  def test_disjoint_non_empty_and_empty
    skip
    set = CustomSet.new([1])
    assert_equal true, set.disjoint?(CustomSet.new)
  end

  def test_disjoint_shared_element
    skip
    set = CustomSet.new([1, 2])
    assert_equal false, set.disjoint?(CustomSet.new([2, 3]))
  end

  def test_disjoint_no_shared_elements
    skip
    set = CustomSet.new([1, 2])
    assert_equal true, set.disjoint?(CustomSet.new([3, 4]))
  end

  def test_eql_empty
    skip
    empty_set = CustomSet.new
    assert_equal true, empty_set.eql?(CustomSet.new)
  end

  def test_eql_empty_and_non_empty
    skip
    empty_set = CustomSet.new
    assert_equal false, empty_set.eql?(CustomSet.new([1, 2, 3]))
  end

  def test_eql_non_empty_and_empty
    skip
    empty_set = CustomSet.new([1, 2, 3])
    assert_equal false, empty_set.eql?(CustomSet.new)
  end

  def test_eql_same_elements
    skip
    set = CustomSet.new([1, 2])
    assert_equal true, set.eql?(CustomSet.new([2, 1]))
  end

  def test_eql_different_elements
    skip
    set = CustomSet.new([1, 2, 3])
    assert_equal false, set.eql?(CustomSet.new([1, 2, 4]))
  end

  def test_eql_duplicate_elements_do_not_matter
    skip
    set = CustomSet.new([1, 2, 2, 1])
    assert_equal true, set.eql?(CustomSet.new([2, 1]))
  end

  def test_add_to_empty
    skip
    set = CustomSet.new
    set.add(3)
    assert_equal CustomSet.new([3]), set
  end

  def test_add_to_non_empty
    skip
    set = CustomSet.new([1, 2, 4]).add(3)
    expected = CustomSet.new([1, 2, 4, 3])
    assert_equal expected, set
  end

  def test_add_existing_element
    skip
    set = CustomSet.new([1, 2, 3]).add(3)
    expected = CustomSet.new([1, 2, 3])
    assert_equal expected, set
  end

  def test_intersection_empty
    skip
    set = CustomSet.new.intersection(CustomSet.new)
    expected = CustomSet.new
    assert_equal expected, set
  end

  def test_intersection_empty_and_non_empty
    skip
    set = CustomSet.new.intersection(CustomSet.new([3, 2, 5]))
    expected = CustomSet.new
    assert_equal expected, set
  end

  def test_intersection_non_empty_and_empty
    skip
    set = CustomSet.new([3, 2, 5]).intersection(CustomSet.new)
    expected = CustomSet.new
    assert_equal expected, set
  end

  def test_intersection_no_shared_elements
    skip
    first_set = CustomSet.new([1, 2, 3])
    second_set = CustomSet.new([4, 5, 6])
    actual = first_set.intersection(second_set)
    expected = CustomSet.new

    assert_equal expected, actual
  end

  def test_intersection_shared_elements
    skip
    first_set = CustomSet.new([1, 2, 3, 4])
    second_set = CustomSet.new([3, 2, 5])
    actual = first_set.intersection(second_set)
    expected = CustomSet.new([2, 3])

    assert_equal expected, actual
  end

  def test_difference_empty
    skip
    actual = CustomSet.new.difference(CustomSet.new)
    assert_equal CustomSet.new, actual
  end

  def test_difference_empty_and_non_empty
    skip
    actual = CustomSet.new.difference(CustomSet.new([3, 2, 5]))
    expected = CustomSet.new
    assert_equal expected, actual
  end

  def test_difference_non_empty_and_empty
    skip
    actual = CustomSet.new([1, 2, 3, 4]).difference(CustomSet.new)
    expected = CustomSet.new([1, 2, 3, 4])
    assert_equal expected, actual
  end

  def test_difference_non_empty_sets
    skip
    actual = CustomSet.new([3, 2, 1]).difference(CustomSet.new([2, 4]))
    expected = CustomSet.new([3, 1])
    assert_equal expected, actual
  end

  def test_union_empty
    skip
    actual = CustomSet.new.union(CustomSet.new)
    expected = CustomSet.new
    assert_equal expected, actual
  end

  def test_union_empty_and_non_empty
    skip
    actual = CustomSet.new.union(CustomSet.new([2]))
    expected = CustomSet.new([2])
    assert_equal expected, actual
  end

  def test_union_non_empty_and_empty
    skip
    actual = CustomSet.new([1, 3]).union(CustomSet.new)
    expected = CustomSet.new([1, 3])
    assert_equal expected, actual
  end

  def test_union_non_empty_sets
    skip
    actual = CustomSet.new([1, 3]).union(CustomSet.new([2, 3]))
    expected = CustomSet.new([1, 2, 3])
    assert_equal expected, actual
  end
end
```

## Solution:
```ruby
=begin  
P
  A Set is a  type of custom object. It behaves like a "set", having unique elements that can be manipulated.
  There is a built-in `Set` type in Ruby - but I can't use it, only play around with it afterwards.

  Terms:
    - The "set" is a mock-Array object

    methods:
      * new(arr=[]) 
      * empty?      
      * contains?(arg)
      * subset?(other_set)
      * disjoint?(other_set)
      * eql?(other_set)
      * add(item)
      * intersection(other_set)
      * difference(other_set)
      * union(other_set)
=end

class CustomSet 
  attr_accessor :items

  def initialize(arr = [])
    @items = arr
  end

  def empty?
    items.empty?
  end

  def contains?(item)
    items.include?(item)
  end

  def subset?(other_set)
    items.size <= other_set.items.size &&
    items.all? { |item| other_set.items.include?(item) }
  end

  def disjoint?(other_set)
    items.none? { |item| other_set.items.include?(item) }
  end

  def eql?(other_set)
    return true  if empty? && other_set.empty?
    return false if empty? || other_set.empty?

    other_set.items.all? { |item| items.include?(item) }
  end

  def add(item)
    items.push(item) unless items.include?(item)
    self
  end

  def intersection(other_set)
    intersecting_items = items.select { |item| other_set.items.include?(item) }.uniq
    CustomSet.new(intersecting_items)
  end

  def difference(other_set)
    return CustomSet.new([]) if empty?
    different_items = items.reject { |item| other_set.items.include?(item) }.uniq
    CustomSet.new(different_items)
  end

  def union(other_set)
    unioned = (items + other_set.items).uniq
    CustomSet.new(unioned.sort)
  end

  def ==(other_set)
    items == other_set.items
  end
end
```
