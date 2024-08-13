=begin  
Write a program to determine whether a triangle is equilateral, isosceles, or scalene.

An equilateral triangle has all three sides the same length.

An isosceles triangle has exactly two sides of the same length.

A scalene triangle has all sides of different lengths.

Note: For a shape to be a triangle at all, all sides must be of length > 0, 
and the sum of the lengths of any two sides must be greater than the length of the third side.

P
  Input  -> Triangle object (instantiated with side lengths)
  Output -> String (representing the type of Triangle)

DS
  Array (of lengths) --> Integers (representing the sides) --> String (describing kind of triangle)

ALGO
  *** Whether a Triangle is a legitimate Triangle, this can be calculated at initialization of a Triangle.
  (IF all values must be greater than 0 && sum of any two sides must be greater than the length of the third side)

  1. CREATE `Triangle#kind`
    a) Accesses the `sides` of the Triangle instance
    b) Determines cases:
      - Are all side values equal? THEN RETURN 'equilateral'
      - Are two side values equal? THEN RETURN 'isosceles'
      - Are all side values different? THEN RETURN 'scalene'
=end

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

p (0.5 + 1.5) % 1
