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
    @set = (set.empty? ? [3, 5] : set)
  end

  def self.to(target)
    range = (1..target-1)
    range.select { |num| [3, 5].any? { |set_num| num % set_num == 0 } }.sum
  end

  def to(target)
    range = (1..target-1)
    range.select { |num| set.any? { |set_num| num % set_num == 0 } }.sum
  end
end
```

---
---


---
---

