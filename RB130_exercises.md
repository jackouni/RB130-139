# Easy Testing

### Question 1: Boolean Assertions

QUESTION:
> Write a minitest assertion that will fail if the value.odd? is not true.

ANSWER:
>```ruby
>class ValueTest < Minitest::Test
> def test_odd
>   assert(@value.odd?)
> end
>end
>```

---

### Question 2: Equality Assertions

QUESTION: 
> Write a minitest assertion that will fail if value.downcase does not return 'xyz'.

ANSWER:
>```ruby
>class ValueTest < Minitest::Test
> def test_downcase
>   assert_equal('xyz', @value.downcase)
> end
>end
>```

---

### Question 3: Nil Assertions

QUESTION:
> Write a minitest assertion that will fail if value is not nil.

ANSWER:
>```ruby
>class ValueTest < Minitest::Test
> def test_nil
>   assert_nil(@value)
> end
>end
>```

---

### Question 4: Empty Object Assertions

QUESTION: 
> Write a minitest assertion that will fail if the Array list is not empty.

ANSWER:
>```ruby
>class ListTest < MiniTest::Test
> def setup
>   @list = List.new
> end
>
> def test_array
>   assert_empty(@list)
> end
>end
>```

---

### Question 6: Exception Assertions 

QUESTION: 
> Write a minitest assertion that will fail unless employee.hire raises a NoExperienceError exception.

ANSWER:
>```ruby
>class NoExperienceError < StandardError; end
>
>class Employee 
>   def hire
>     raise NoExperienceError 
>   end
>end
>
>class EmployeeTest < Minitest::Test
>   def setup
>     @employee = Employee.new
>   end
>
>   def test_no_experience_error
>     assert_raises(NoExperienceError) { @employee.hire }
>   end
>end
>```

---

### Question 7: Type Assertions 

QUESTION: 
> Write a minitest assertion that will fail if value is not an instance of the Numeric class exactly. value may not be an instance of one of Numeric's superclasses.

ANSWER:
>```ruby
>class SomeTest < Minitest::Test
> def test_
>   value = 10
>   assert_instance_of(Numeric, Numeric.new) # Passes
>   assert_instance_of(Numeric, value)       # Fails
> end
>end
>```

---

### Question 8: Kind Of Assertions 

QUESTION: 
> Write a minitest assertion that will fail if value is not an instance of the Numeric class exactly. value may not be an instance of one of Numeric's superclasses.

ANSWER:
>```ruby
>class SomeTest < Minitest::Test
>   def test_
>     value = "Hello"
>     assert_kind_of(Numeric, 101)         # Passes
>     assert_kind_of(Numeric, Numeric.new) # Passes
>     assert_kind_of(Numeric, value)       # Fails
>   end
>end
>```

---

### Question 9: Same Object Assertions 

QUESTION: 
> Write a test that will fail if list and the return value of list.process are different objects.

ANSWER:
>```ruby
>class List
>  attr_reader :items
>
>  def initialize(*values)
>    @items = values
>  end
>
>  def process
>    # ... code processing values
>    self
>  end
>end
>
>class SomeTest < Minitest::Test
>  def setup
>    @list = List.new(1, 2, 3)
>  end
>
>  def test_
>    assert_same(@list, @list.process)
>  end
>end
>```

---

### Question 10: Refute Assertions 

QUESTION: 
> Write a test that will fail if 'xyz' is one of the elements in the Array list:

ANSWER:
>```ruby
>class SomeTest < Minitest::Test
>  def setup
>    @list = ["Hello", "World", "!!"]
>  end
>
>  def test_
>    refute_includes(@list, 'xyz')
>  end
>end
>```

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

# Question 4: "Passing Parameters Part 2" 

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

---
---

# Question 6: "Method to Proc" 

## Test Cases Provided:
```ruby
[8, 10, 12, 14, 16, 33].map(&a_proc_placeholder) 
# Method call above should return:
# => [10, 12, 14, 16, 20, 41]

[8, 10, 12, 14, 16, 33].map(&a_proc_placeholder) == [10, 12, 14, 16, 20, 41] # => True
```

## Solution:
```ruby
# SOLUTION #1:
def convert_to_base_8(n)
  n.to_s(8).to_i
end

base8_proc = method(:convert_to_base_8).to_proc

answer    = [8, 10, 12, 14, 16, 33].map(&base8_proc) 
p answer == [10, 12, 14, 16, 20, 41] #=> true

# SOLUTION #2:
def convert_to_base_8(n)
  n.to_s(8).to_i
end

answer    = [8, 10, 12, 14, 16, 33].map(&method(:convert_to_base_8)) 
p answer == [10, 12, 14, 16, 20, 41] #=> true
```

# Question 7: Bubble Sort with Blocks

## Test Cases:
```ruby
array = [5, 3]
bubble_sort!(array)
array == [3, 5]

array = [5, 3, 7]
bubble_sort!(array) { |first, second| first >= second }
array == [7, 5, 3]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
array == [1, 2, 4, 6, 7]

array = [6, 12, 27, 22, 14]
bubble_sort!(array) { |first, second| (first % 7) <= (second % 7) }
array == [14, 22, 12, 6, 27]

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array)
array == %w(Kim Pete Tyler alice bonnie rachel sue)

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) { |first, second| first.downcase <= second.downcase }
array == %w(alice bonnie Kim Pete rachel sue Tyler)
```

## Solution:
```ruby
def bubble_sort!(arr)
  loop do
    swap_is_made = false

    arr.each_index do |ind|
      break if ind == arr.size - 1
      a, b = arr[ind, 2]

      next if (block_given? ? yield(a, b) : a <= b)
      arr[ind, 2] = [b, a]
      swap_is_made = true
    end

    break unless swap_is_made 
  end
end
```

---
---
---
---
