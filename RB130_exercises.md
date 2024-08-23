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

