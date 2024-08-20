# Ruby Installation

"Ruby installation" refers to how the Ruby programming language ends up on your development environment. 
The *"development environment"* can refer to either the machine you're working on or the cloud-based environment you're working on, like cloud9.

MacOS usually comes with Ruby already on it. 
You can check what version of Ruby is installed on your Mac machine using the terminal command: 
`/usr/bin/ruby -v`

This is usually not optimal though, as the version of Ruby installed with MacOS is probably outdated. On top of this, the Ruby that is on your Mac needs root access to make any modifications to other Ruby components you may have installed. Ideally developers want to avoid directly logging in as root user, and sometimes developers don't have access to root user privelages which can make this hard to use.

# Terminology

"**DSL (Domain Specific Language)**"
> Is a language that is designed to be used and fit a specific need. It isn't a **General Programming Language** *(like Ruby, JavaScript, Python, etc...)* because it can't be used in a wider more broad sense. This is language designed specifically for a certain task or problem.

"**Test Suite**"
> A "*test suite*" refers to all of the tests being run for your program. 

"**Test**"
> These are the individual tests that make up a test suite. Tests can contain multiple assertions.

"**Assertion**"
> You can think of an "*assertion*" a way to verify/check if specific data in your code returns an expected output, given some conditions. An assertion allows us to test an assumption about our code to see if it's true.

---

---

# Minitest

This is the standard testing software for Ruby. 

There is also RSpec, but Minitest is Ruby's standard testing library.

### Installation of Minitest

To install MiniTest run the command: `gem install minitest`

To check what version you have run command: `gem list minitest`

To install a specific version of minitest run: `gem install minitest -v <version number>`

### Setting up

Once we have Minitest installed we can create a test file that will represent a test suite for a file. The general naming convention here is that the test file should be the name of the file we're testing with '_test.rb' appended. So if you're testing a `game.rb` file, then you should call the testing file `game_test.rb`.

At the top of the test file you need to load 2 other files:
1. Minitest files that'll you'll be using
2. The file you want to test

The top of your testing file should look like this:
```ruby
require 'minitest/autorun' # Loads parts of Minitest we want to use 
require_relative 'game.rb' # Loads in the file we want to test on

# ...
```

Let's say our `game.rb` looks like this:

```ruby
class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end
end
```

Next step is to set up your specific tests in your `game_test.rb` file:

```ruby
require 'minitest/autorun' 
require_relative 'game.rb' 

class PersonTest < Minitest::Test #=> This inheritance happens in order to get Minitest methods we need
  def test_name #=> Define a method with `test` prepended. This tells Minitest that this is a test.
    joe = Person.new('Joe', 30)   #=> Create the conditions you want to test under
    assert_equal('Joe', joe.name) #=> Use an assertion method to check an assertion
  end
end
```

There are a bunch of *assertion methods* that come with Minitest. It can be assumed that in our test above that `assert_equal` is a method that is being inheritted from somewhere up the hierarchy chain.

`assert_equal` takes 2 arguments:
1. The value you expect
2. The test value

### Reading Outputs

If everything goes well our test should return something like this:

```
# Running: 

PersonTest .

Finished in 0.000324s, 2132.1961 runs/s, 2132.1961 assertions/s.
1 runs, 1 assertions, 0 failures, 0 errors, 0 skips
```

What do these all mean?

The second line `PersonTest .` tells us that the `PersonTest` tests ran.

The dot in this line shows that the test ran and nothing went wrong. If it failed it would show an `F` and if it was skipped it would show a `S`

So what happens if a test failed? For example:
```ruby
# ... require statements hidden for brevity

class PersonTest < Minitest::Test 
  def test_name 
    joe = Person.new('Joe', 30)   
    assert_equal('Joe', joe.name) 
  end

  def test_name_again
    joe = Person.new('Joe', 30)
    assert_equal('James', joe.name)
  end
end
```

If we ran minitest it would result in an output like this:

```
# Running:

PersonTest F.

Finished in 0.000493s, 4056.7949 runs/s, 4056.7949 assertions/s.

1) Failure:
PersonTest#test_name_again [game_test.rb:<line number>]:
Expected: 'Joe'
  Actual: 'James'

2 runs, 2 assertions, 1 failures, 0 errors, 0 skips
```

As you can see the first line tells us that `PersonTest` test had 1 failure, `F`, and 1 pass, `.`.

Further down we can see that Minitest will tell us the `Failure`, what line the assertion failed as well as the expected value VS the actual value.

And on the final line it can be seen that there were 2 runs (both defined tests), 2 assertions (the single `assert_equal` methods in each test), 1 failure (the last assertion method that failed), 0 errors in running the tests themselves, and 0 tests skipped.

**Add some color:** You can `gem install minitest-reporters` and then add this code to the header of your testing file:
```ruby
require "minitest/reporters" # Loads the files to color-code your test outputs
Minitest::Reporters.use!     # Method call that invokes the use of the color-coding
```

### Skipping a Test

Sometimes you'll want to skip certain tests for whatever reasons. To skip a test all you have to do is add the `skip` method call within the test methods.

Example:
```ruby
# ... require statements hidden for brevity

class PersonTest < Minitest::Test 
  def test_name 
    skip
    joe = Person.new('Joe', 30)   
    assert_equal('Joe', joe.name) 
  end

  def test_age
    joe = Person.new('Joe', 30)
    assert_equal(30, joe.age)
  end
end
```

This will skip the `test_name` test and will be shown as a 'skip' in the Minitest output.

### Types of Assertions

| Assertion                        | Description |
| ---------                        | ----------- |
| assert(test)                     | Fails unless test is truthy. |
| assert_equal(exp, act)           | Fails unless exp == act. |
| assert_nil(obj)                  | Fails unless obj is nil. |
| assert_raises(exp) { ... }       | Fails unless block raises one of exp. |
| assert_instance_of(cls, obj)     | Fails unless obj is an instance of cls. |
| assert_includes(collection, obj) | Fails unless collection includes obj. |

