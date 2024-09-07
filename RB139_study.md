# My Study Sheet for RB139 Exam:

# Closures, Blocks, Procs, Lambdas...

## What are blocks?

In Ruby, blocks are chunks of code contained between either `{...}` or `do...end` syntax **and** are associated with a method invocation. There are other code structures in Ruby that use block-like syntax but **are not** considered blocks. A couple examples of *non-block* Ruby code that uses block-like syntax include:

```ruby
hash = { a: 1, b: 2 } # Hash literals

loop do # Looping structures (loop, while, until...)
  break
end
```

---
---

## Creating a Custom `loop` method:

```ruby
def my_loop(&block)
  return if block.call
  my_loop(&block)
end

counter = 0

my_loop do
  counter += 1
  puts counter
  counter == 10
end
```

---
---

## What is a Closure?

A closure is a chunk of code that can reference artifacts (like variables and methods) that were defined within the lexical environment in which the closure was instantiated within, even after the execution of that lexical environment. Closures allow for a way to pass around chunks of code that can be executed that can still access variables defined within the lexical scope they were created within.

**Here's an example to demonstrate:**

```ruby
def some_method
  x = 10
  Proc.new { |i| x += i }
end

counter1 = some_method
counter2 = some_method

p counter1.call(10)  #=> 20
p counter2.call(90)  #=> 100
p counter2.call(450) #=> 550
p counter1.call(5)   #=> 25
```

As seen in the above example a closure is created with the return value of `some_method`, a new `Proc` object. Each `Proc` returned from `some_method` has access to the their version of `x` that was initialized in the scope they were created within.

---
---

## Why Use Blocks / When to Use Blocks
#### *(Lesson 1: Writing Methods that take Blocks - When to use blocks in your own methods)*

1. Defer some implementation code to method invocation decision.

> You may consider implementing the use of blocks when creating methods that want the **method user** to determine some portion of the method's implementation at the time of invocation. This could be implementation that is more context specific and where you would give a user of that method some say over the implementation.

In a world where there are no blocks, you may have to implement some kind of *"flag"* parameter for your method, where a method user could pass a **specific** argument that could then be used within the method's implementation to determine what type of pre-built method implemention you would execute.

For example:
```ruby
def maths(operand1, operand2, flag)
  case flag
  when :add      then operand1 + operand2
  when :subtract then operand1 - operand2
  when :multiply then operand1 * operand2
  when :divide   then operand1 / operand2
  else "Sorry no flag found"
  end
end

maths(12, 4, :add)      #=> 16
maths(12, 4, :subtract) #=> 8
maths(12, 4, :multiply) #=> 48    
maths(12, 4, :divide)   #=> 3
maths(12, 4, :random)   #=> "Sorry no flag found"
```

In the example above, the method user must have knowledge of the correct flags to pass, and even then the method user is limited to the implementations given by the **method implementor**.

If we wanted to make this method more flexible and allow a method user to have more say over how the implementation details, we could implement a block like this:

```ruby
def maths(operand1, operand2)
  yield(operand1, operand2) if block_given?
end

maths(12, 4) { |a, b| a + b - 10 } #=> 6
maths(12, 4) { |a, b| a * 3 + b }  #=> 40
maths(12, 4) { |a, b| a * a / 3 }  #=> 48
maths(12, 4) { "Hello World!!!" }  #=> Hello World!!!
maths(12, 4)                       #=> nil
```

2. Methods that need to perform some "before" and "after" actions - sandwich code.

This is when we want to perform a *"before"* and *"after"* action. The definition of a *"before" and "after" action* is vague and could mean a lot of things - it's pretty open. What happens between "before" and "after"? Answer: potentially whatever the **method user** may want. This can be done by allowing a method user to pass a block to implement something inbetween the before and after parts of a method. 

Here's an example to demonstrate:
```ruby
File.open('some_file_path/file.txt') do |file|
  # Some implementation for that file...
end
```

In the above example we're opening a file *(`some_file_path/file.txt`)* and doing something with that file. Afterwards the `File::open` method will close the file.

Here the hard-coded implementation of `File::open` is opening a file and then closing that file. The method user determines the implementation between the file opening and closing. The block in the example, that was passed to `File::open` is an example of a method user deciding implementation details between the *"before"* (opening a file) and *"after"* (closing a file) events.

---
---

## Methods with an explicit block parameter

Methods often can take an **implicit block**, meaning the block to be passed is not being defined as an parameter for that method. You can pass a block to a method and the method will `yield` that block passed if a `yield` is defined in the method implementation. You may not pass a block too, and it would still take it *(although it may run into a `LocalJumpError` if there's an unconditional `yield` in the method implementation)*.

An explicit block is when you define a parameter for a method to have a block passed to it. This means a parameter can **bind** to the block argument, allowing us to pass the block argument around.

Using the `&` operator we can define a parameter to take an **explicit block**, like so:
```ruby
def my_method(&block)
  block.call
end

my_method { puts "I'm a block" } # Outputs: I'm a block
```

As seen above, the block argument passed to `my_method` is being executed. This happens with the `block.call`.

What's happening here is that the `&` operator being prepended to a method parameter, will attempt to convert the argument passed to a `Proc` object. The `Proc` is a way to store blocks as an object that can be passed around.

Why do this? Like I said, this is great if you want to pass a block around to other methods, something you can't do without an explicit block defined. Like so:

```ruby
def test1(&block)
  puts "I'm doing some work in test1"
  test2(block)
  puts "Finishing off test1"
end

def test2(block)
  puts "Doing some work in test2..."
  block.call
end

test1 { puts "This explicit block is doing some work!" }

# Outputs:
# I'm doing some work in test1
# Doing some work in test2...
# This explicit block is doing some work!
# Finishing off test1
```

---
---

## Custom `each` method

### As a standalone method:

```ruby
arr = [2, 4, 6]

def each(arr)
  counter = 0

  until counter >= arr.size do
    yield(arr[counter])
    counter += 1
  end

  arr
end

each(arr) { |item| puts item + 1 }
# Output:
# 3
# 5
# 7
#=> [2, 4, 6]
```

### As an instance method:

```ruby
class Arr 
  attr_accessor :items

  def initialize(*items)
    @items = items
  end

  def each 
    items.each { |item| yield(item) }
  end
end

Arr.new(1, 2, 3).each { |n| puts n * 10 }
# Output:
# 10
# 20
# 30
#=> [1, 2, 3]
```

---
---

## Custom `map` method:

### As a standalone method:

```ruby
arr = [2, 4, 6]

def map(arr)
  results = []
  counter = 0

  until counter >= arr.size do
    item = arr[counter]
    results << yield(item)
    counter += 1
  end

  results
end

map(arr) { |item| item + 1 } #=> [3, 5, 7]
```

### As an instance method:

```ruby
class Arr 
  attr_accessor :items

  def initialize(*items)
    @items = items
  end

  def map 
    items.map { |item| yield(item) }
  end
end

Arr.new(1, 2, 3).map { |n| n * 10 } #=> [10, 20, 30]
```

---
---

## Custom `select` method:

### As a standalone method:

```ruby
arr = [2, 4, 6, 8, 9]

def select(arr)
  selected = []
  counter = 0

  until counter >= arr.size do
    item = arr[counter]
    selected << item if yield(item) 
    counter += 1
  end

  selected
end

select(arr) { |item| item % 3 == 0 } #=> [3, 9]
```

### As an instance method:

```ruby
class Arr 
  attr_accessor :items

  def initialize(*items)
    @items = items
  end

  def select 
    items.select { |item| yield(item) }
  end
end

Arr.new(1, 2, 3, 4).select { |n| n.even? } #=> [2, 4]
```

---
---

## Custom `reduce` method:

### As a standalone method:

```ruby
arr = [2, 4, 6]

def reduce(arr, accumulator = 0)
  acc = accumulator
  counter = 0

  until counter >= arr.size do
    item = arr[counter]
    acc = yield(acc, item) 
    counter += 1
  end

  acc
end

reduce(arr) { |acc, item| acc + item } #=> 12
```

### As an instance method:

```ruby
class Arr 
  attr_accessor :items

  def initialize(*items)
    @items = items
  end

  def reduce(acc = 0)
    items.reduce(acc) { |acc, item| yield(acc, item) }
  end
end

Arr.new(1, 2, 3, 4).reduce { |acc, n| acc + n } #=> 10
```

---
---

## Custom `each_with_object` method:

### As a standalone method:

```ruby
arr = [2, 4, 6]

def each_with_object(arr, obj)
  counter = 0

  until counter >= arr.size do
    item = arr[counter]
    yield(item, obj)
    counter += 1
  end

  obj
end

p each_with_object(arr, []) { |item, obj| obj << item*100 } #=> [200, 400, 600]
```

### As an instance method:

```ruby
class Arr 
  attr_accessor :items

  def initialize(*items)
    @items = items
  end

  def each_with_object(acc = 0)
    items.each_with_object({}) { |item, obj| yield(item, obj) }
  end
end

p Arr.new(1, 2, 3).each_with_object { |n, obj| obj[n.to_s] = n.to_f } #=> { "1" => 1.0, "2" => 2.0, "3" => 3.0 }
```

---
---

## Custom `times` method:

### As a standalone method:

```ruby
def times(num)
  counter = 0

  until counter == num
    yield(counter)
    counter += 1
  end

  num
end

times(4) { |n| puts n }
# Outputs: 
# 1
# 2
# 3
#=> 4
```

### As a custom instance method:

```ruby
class Int
  attr_reader :int

  def initialize(int)
    @int = int
  end

  def times
    (0...int).each { |n| yield(n) }
    int
  end
end

Int.new(4).times { |n| puts n*10 } 
# Outputs: 
# 0
# 10
# 20
# 30
#=> 4
```

---
---

## Using `&` Operator

The `&` operator has 2 main purporses:

#### 1. Convert a block to a `Proc`

When prepended to the name of a method parameter, the `&` operator will convert a given block or argument to a `Proc` object to be used within the method. This is also known as defining an **explicit block** for a method. By doing so you're now able to pass a block around as a `Proc` within the method definition. If no block is given, the **explicit block parameter** will reference `nil`, this also means if you try to invoke `#call` on that parameter, an error will be raised because of the attempt to invoke `#call` on `nil`.

**Example:**

```ruby
def my_method(a, b, &block)
  puts a 
  puts b 
  puts block.call
end

meth(1, 2) { "Hello World" }

# Outputs:
# 1
# 2
# Hello World
```

The block, `{ "Hello World" }` is being converted a `Proc` object in `my_method`, and is referenced by the parameter `block`.

###### ***Weird quirk:***

The block still exists, and you can still `yield` it to the method, but now there's a `Proc` version of the block to use too. See this tweaked example:
```ruby
def meth(a, b, &block)
  puts a 
  puts b 
  puts yield
  puts block.call
end

meth(1, 2) { "Hello World" }

# Outputs:
# 1
# 2
# Hello World
# Hello World
```

#### 2. Convert an argument into a block

When prepended to an argument, the `&` operator will attempt to convert the given argument to a block. Usually we're passing a `Proc` as the argument, but `Symbol` arguments can also have the `&` operator prepended to them as well and converted to blocks.

Here's an example:
```ruby
def my_method(a, b)
  puts a 
  puts b 
  puts yield
end

my_proc = Proc.new { "Hello World" }
my_method(1, 2, &my_proc) 

# Outputs:
# 1
# 2
# Hello World
```

As seen above, there's no need to define a parameter for the `Proc`, `my_proc`, passed to `my_method`. The `&` operator prepended to `my_proc` will convert `my_proc` to a block that can then `yield` to the method.

###### ***Another tidbit:***

You can only pass either a block or a block argument with `&`, NOT both. If this is attempted an error will occur with this message: `both block arg and actual block given`

**Here's an example that would not work and would raise that error:**

```ruby
def my_method(a, b)
  puts a 
  puts b 
  puts yield
end

my_proc = Proc.new { "Hello World" }
my_method(1, 2, &my_proc) { "I'm another block being passed" }
# Error message:
# both block arg and actual block given
```

**An easy way to remember which scenario does what you can say:**
> *"Parameter to `Proc`."* <br>
> *"Argument to Block."*

---
---

## Why Blocks Themselves Are Considered a Type of Closure

In Ruby blocks are closures. How so?

Blocks, when created, are able to reference and access the artifacts in their surrounding lexical scope. 

This is demonstrated when a block is passed to a method as an argument. The block can reference artifacts like variables in its surrounding lexical environment. When the block yields in the method it still has access to those artifacts it's binded to.

**Here's an example to demonstrate:**

```ruby
def some_method
  yield
end

value = "Heyo"

some_method { value } #=> "Heyo"
```

Despite the variable `value` being out of scope for `some_method`, the block passed to `some_method` can reference `value` and when it yields in `some_method` it's still able to return and reference `value`.

---
---

## `Symbol#to_proc` / Symbol to Proc

When the `&` operator is prepended to an argument, it attempts to convert the given argument to a block. If the argument is a `Proc` object `&` naturally converts it to a block to `yield` in the method. If the argument is not a `Proc` object then `&` will attempt to first convert the given argument to a `Proc` using the `#to_proc` method. 

In the case of `Symbol` objects as arugments with `&` prepended, the `Symbol#to_proc` method is called to convert the `Symbol` into a `Proc`. When this is done, a method with the same name as the `Symbol` is converted to its `Proc` counterpart. From here, the `Proc` is then converted into a block.

**Here's a custom example to demonstrate:**

```ruby
class Item
  def initialize(value)
    @value = value
  end

  def double
    @value * 2
  end

  def triple
    @value * 3
  end

  def to_nil
    nil
  end
end

items = [Item.new("Hello"), Item.new(25), Item.new(1.25)]

items.map(&:to_nil) == [nil, nil, nil]               #=> true
items.map(&:double) == ["HelloHello", 50, 2.5]       #=> true
items.map(&:triple) == ["HelloHelloHello", 75, 3.75] #=> true
```

It's also worth noting that you cannot pass arguments to the `&:symbol` syntax like you could with a regular method call.

---
---

## Block Arity / Proc Arity / Method Arity / Lenient Arity / Strict Arity

The term arity is used to describe how something takes arguments. 

When something is described as having **lenient arity** this means it doesn't need to take the exact number of arguments as defined in the parameters, it could take more or less and won't raise any errors. Blocks and `Procs` have **lenient arity**.

When something is described as **strict arity** this means it needs to take the exact number of arguments as defined in the parameters, if it isn't given the correct numbe rof arguments, it will raise an `ArgumentError`. Methods and lambdas are said to have strict arity.

**Here is an example demonstrating leninent arity in `Proc` objects:**
```ruby
my_proc = Proc.new { |x, y| puts "value x: #{x.inspect} | value y: #{y.inspect}"}

my_proc.call # No args passed
# Outputs:
# value x: nil | value y: nil

my_proc.call(10) # Too few args passed
# Outputs:
# value x: 10 | value y: nil

my_proc.call("hi", "mid", "lo") # Too many args passed
# Outputs:
# value x: hi | value y: mid
```

As seen above, `Proc` objects don't need to have the exact number of arguments passed as defined in their block parameters. Any remaining arguments that are not fulfilled/given will reference `nil` and any extra arguments will be ignored. 

**Here is an example demonstrating strict arity in lambdas:**
```ruby
my_lambda = lambda { |x, y| puts "value x: #{x} | value y: #{y}"}

my_lambda.call
# Error is raised:
# wrong number of arguments (given 0, expected 2) (ArgumentError)
```

As seen above, the lambda needs to take the exact number of arguments as defined in the block parameters, `|x, y|`.

The above glosses over a lot of other types of arguments used in Ruby, and is just a high-level overview of the concept of "arity". 

---
---

## When Can You Pass a Block to a Method?

All methods can accept a block. Whether a method does something with that block is up to the method's implementation. 

If a method does not use the `yield` keyword in its' definition, the block will simply be ignored and won't be used.

If a method uses the `yield` keyword (unconditionally) in its' definition, a block will yield to it and will be executed, otherwise if no block is passed to the method a `LocalJumpError` will be raised.

Examples:
```ruby
def no_yield
end

def with_yield
  yield
end

def explicit_block_call(&block)
  block.call
end

def explicit_block_no_call(&block)
end

x = "Some value"

no_yield   { x }             #=> nil
with_yield { x }             #=> "Some value"
explicit_block_call    { x } #=> "Some value"
explicit_block_no_call { x } #=> nil
```

---
---

## Understand That Methods and Blocks Can Return Chunks of Code (closures)

Methods and blocks can return closures. This means they can return chunks of code that can maintain access to artifacts like other methods and variables that were initialized within the scope of the block or method. Here's an example of a method returning multiple closures (`Proc` objects), that have their own references to artifiacts initialized within the method:

```ruby
def closure_maker
  hello = "Hello "

  Proc.new { hello += hello }
end

closure1 = closure_maker
closure2 = closure_maker

closure1.call #=> Hello Hello
closure1.call #=> Hello Hello Hello Hello
closure1.call #=> Hello Hello Hello Hello Hello Hello Hello Hello 

closure2.call #=> Hello Hello
```

As seen above, both `closure1` and `closure2` are returned from `closure_maker`, but each has their own reference to the individual `hello` variable that was initialized within the surrounding lexical environment they were created within. 

When we call these `Proc` objects it becomes apparent that each has a reference to the `hello` that was initialized within their surrounding lexical environment.

---
---
---
---

# Testing

## Testing terminology

### Test Suite

Are the sets of tests for an entire application/program. These are all the tests for your application/program.

### Tests

Are a group of tests used to test a specific aspect of your application/program. A test can contain multiple assertions.

### Assertions

These can be thought of as the individual verfications that make up a test. This is a verification step to confirm that your code returns what is expected from an input or method.

### DSL

This is coding language that is used for a specific domain of coding or development. It has a specific and/or specialized purpose as opposed to being a general language. DSL's are often designed to be more readable with more abstractions as to be more useable to non-coders or domain-specific users. Unlike general purpose languages, DSL's are a little more restrictive in their use cases and are mainly centered around use in their specfic domain.

Some examples of DSL's include:
- Rake
- Rspec
- HTML

### General-Purpose Lanugages

These are coding languages that can be used in a wider variety of areas and are less restrictive in their use cases. General-purpose languages are generally harder to read when compared to DSL's and have less abstractions, requiring the user of the language to have deeper knowledge of programming and coding to fully use it. General-purpose languages have less restrictions, making them more flexible for use across many different domains.

Some examples of General-purpose languages include:
- Ruby
- JavaScript
- Python

### Minitest vs. RSpec

Minitest is a standard Ruby library that enables a user to test code using regular Ruby syntax. RSpec is a DSL that is used to test Ruby code. RSpec reads more like English and is more abstracted version of Ruby code that is used specfically for testing, hence it being considered a DSL.

Both Minitest and RSpec can be installed via the `gem` command, although Minitest generally comes included with installations of Ruby.

---
---

## Using Minitest

### Setting Up A Test Suite

To get started with Minitest you first have to `require` the respective Minitest autorun file and the file you want to test.

**Here's an example:**

```ruby
require 'minitest/autorun'
require 'sample_file.rb'
```

After loading the appropriate files for Minitest to run you then have to create a class with the naming convention of `ClassNameTest`, with the respective class' name you want to test for followed by `Test`, camel cased. 

For this test class to have access to the methods it needs it needs to inherit from `Minitest::Test`. 

Like this: `class ClassNameTest < Minitest::Test ;end`

In this class you can define a `setup` instance method where you can create the setup for each test. This can include initializing common objects you will be using for each test or setting instance variables for objects.

After this you can create other instance methods with the naming `test_` followed by the thing you want to test for. This naming convention is specific to Minitest and allows for Minitest to identify what methods to use for each test. An example of this naming convention could look like: `def test_returns_nil ;end`

Within the `test_` instance methods you can create different assertions to verify for that test. Assertions come in the form of `assert` and `refute` named methods that can be used to make assertions (and refutations). Some examples of these methods include:
- `assert_equal(expected, actual)`
- `assert_instance_of(class, instance)`
- `assert_includes(collection, obj)`
- `assert_same(expected_obj, actual_obj)`

After creating your tests with their assertions, you can now run the `ruby` command followed by the name of the testing file, like so: `ruby testing_file.rb`

**Here's an example of what a test suite might look like:**

```ruby
require 'minitest/autorun'
require 'sample_file.rb'

class SampleClassTest < Minitest::Test
  def setup
    @obj = SampleObj.new
  end

  def test_instance_of_superclass
    assert_instance_of(SampleSuperClass, @obj)
  end

  def test_is_apart_of_collection
    assert_includes([1, 2, @obj], @obj)
  end

  def test_is_a_different_object
    refute_same(SampleObj.new, @obj)
  end
end

# All tests should be successful
```

---
---

## SEAT Approach

The **SEAT approach** is a series of steps that happen when testing. Each letter stands for a different step in the process, in that order.

### S - Setup

The setup, is where we set the variables and objects in place that we will be using for each test. This can generally include instantiating objects we'll be using for each test to setting instance variables. When using a testing app like Minitest, you can define a `setup` method that will run for each test. When setting up like this, repetition and tedious typing can be avoided, as we only have to write our `setup` once.

### E - Execute

This is where the code for the current test executes. In Minitest, this is the invocation of a `test_` instance method in the respective test class.

### A - Assert

This is where we verify and/or validate the results of the executed code for the current test. This is where we evaluate our assertions, checking to see if the expected values returned from an assertion are what is actually returned. 

### T - Teardown

This step happens after each test, this is where any remaining artifacts are removed and cleaned up in order to setup for the next test on a clean slate. This makes sure that artifacts from the current test don't interfere with the next test.

---
---
---
---

# Ruby Tools

## Version Managers

Version managers for Ruby allow you to install and use different versions of Ruby for different projects. Version managers keep track of what version of Ruby you're using for a specific project and help navigate from using one version of Ruby to another.

### Rbenv 

Is a version manager used to install Rubies as well as to switch between different versions of Ruby for different projects, making navigating between specific Rubies for specific projects easier and more seamless.

**Some important commands:**
1. `rbenv versions`
> This displays the versions of Ruby you have installed with rbenv and shows you which version you're currently working with in the directory you're currently in.

2. `rbenv root`
> Shows the where the rbenv directory is located in your machine.

3. `rbenv global RUBY_VERSION`
> Sets the default version of Ruby to use for any Ruby project.

4. `rbenv local RUBY_VERSION`
> Sets the version of Ruby to use for the current directory you're in and its sub-directories.

5. `rbenv install RUBY_VERSION`
> Installs the specified Ruby version to the rbenv directory.

6. `brew install ruby-build`
> Not a rbenv command, but a plugin (for Mac, using homebrew) that is necessary to install in order to more easily install Ruby versions using the rbenv command.

7. `rbenv rehash`
> Rehashes shims to ensure rbenv is aware of all installed executables.

8. `gem env`
> Again, not a rbenv command, but useful for trouble shooting and configuring. This command will display relevant information about how `RubyGems` is set up on your machine.

### RVM

---
---

## RubyGems

RubyGems are packages or libraries of code that can be downloaded from the RubyGems repository, `rubygems.org` . These libraries can include pre-made/pre-built code that can be used by developers in their application to assist them in coding. This can range anywhere from tools, testing apps, to stylizing apps, and etc.

---
---

## Dependency Managers

A dependency manager is a tool that can be used to help maintain gems/packages installed for a specific project. Similar to how Ruby version managers manage multiple versions of Ruby for different projects, dependency managers manage multiple versions of gems/packages across different projects.

**Some things a dependency manager does in Ruby:**
1. Declaring project dependencies in a single file (`Gemfile`)
2. Installing and updating gems and their dependencies
3. Ensuring consistency of gem versions across different development environments

## Bundler

Bundler is the main dependency manager used for Ruby projects.

### Gemfile

This is a file that you create (`GemFile`) where you define the gems and the versions of those gems that you'll be installing for a given project. Bundler uses this `GemFile` to reference when managing dependencies. You can think of a `GemFile` as a set of instructions on how to configure your project's dependencies.

### Gemfile.lock

Once the `bundle install` command runs, Bundler reads the `GemFile` and downloads the defined gems from the `GemFile` along with their own dependencies. Each gem generally has multiple other files and gems to be installed along with it. The `GemFile.lock` is the file bundler produces that shows you what gems are currently installed for the project along with all the dependencies installed for each of those gems as well.

It can be thought of as a current record of what gems and gem-dependencies are installed for the current project.

---
---

## Rake

Rake is an automation tool commonly installed and used for Ruby projects. Rake is generally used for reptitive or common tasks, commands or functions you run during the development process of a project.

### RakeFile

A RakeFile is where you specify the commands and automations you would like to run.

---
---

## Rubocop

---
---
