=begin  
P
  Count the number of differences between two DNA sequences.
  Example:
  GAGCCTACTAACGGGAT
  CATCGTAATGACGGCCT
  ^ ^ ^  ^ ^    ^^

  We can see that there are 7 differences between the two DNA sequences.

  Inputs: String (DNA instance with it's strand)
          String (A "distance", or different strand)

  Output: Integer (representing the numbe rof differences between the 2 inputs)

E
  Terms:
    - Empty strand inputted will RETURN 0
    - Input stands of different lengths will still be measured
    - Input strands of different lengths will be measured up until either strand runs out, ignores the remaining strand

DS
  Inputs String1, String2 --> Array (of chars) --> Output Integer

ALGO

  Notes: 
    - RETURN 0 if either input is empty
    - Iterate over each letter and index of the strand of DNA 
      - BREAK IF the index is >= the input strand's length
      - compare current letter with the letter at the current index in the input strand
        - IF they are not the same THEN INCREMENT a difference_counter
        - ELSE GO NEXT TO letter

    - RETURN difference_counter
=end

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