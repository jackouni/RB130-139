# My Study Sheet for RB139 Exam:

## What is a Closure?

A closure is a chunk of code that can reference variables and other methods that were defined within the lexical environment in which the closure was instantiated within, even after the execution of that lexical environment. Closures allow for a way to pass around chunks of code that can be executed, that can still access variables defined within lexical scope they were created within.

Here's an example to demonstrate:

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

Generally closures can be created from return values of methods and blocks. 

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

## Block Scope / Block Scoping Rules



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

Why do this? Like I said this is great if you want to pass a block around to other methods, something you can't do without an explicit block defined. Like so:

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

## Using `&` Operator

The `&` operator has 2 main purporses:

#### 1. Convert a block to a `Proc`

When prepended to the name of a method parameter, the `&` operator will convert a given block or argument to a `Proc` object to be used within the method. This is also known as defining an **explicit block** for a method. By doing so you're now able to pass a block around as a `Proc` within the method definition. If no block is given, the **explicit block parameter** will reference `nil`, this also means if you try to invoke `#call` on that parameter, an error will be raised because of the attempt to invoke `#call` on `nil`.

**Example:**

```ruby
def meth(a, b, &block)
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

The block, `{ "Hello World" }` is being converted a `Proc` object in `meth`, and is referenced by the parameter `block`.

***Weird quirk:***

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
def meth(a, b)
  puts a 
  puts b 
  puts yield
end

my_proc = Proc.new { "Hello World" }
meth(1, 2, &my_proc) 

# Outputs:
# 1
# 2
# Hello World
```

As seen above, there's no need to define a parameter for the `Proc`, `my_proc`, passed to `meth`. The `&` operator prepended to `my_proc` will convert `my_proc` to a block that can then `yield` to the method.

***Another tidbit:***

You can only pass either a block or a block argument with `&`, NOT both. If this is attempted and error will be raised with this message: `both block arg and actual block given`

Here's an example that would not work and would raise that error:

```ruby
def meth(a, b)
  puts a 
  puts b 
  puts yield
end

my_proc = Proc.new { "Hello World" }
meth(1, 2, &my_proc) { "I'm another block being passed" }

# Outputs:
# 1
# 2
# Hello World
```

**An easy way to remember which scenario does what you can say:**
> *"Parameter to `Proc`."* <br>
> *"Argument to Block."*

---
---

## Blocks are closures

---
---

## `Symbol#to_proc` / Symbol to Proc

When the `&` operator is prepended to an argument, it attempts to convert the given argument to a block. If the argument is a `Proc` object `&` naturally converts it to a block to `yield` in the method. If the argument is not a `Proc` object then `&` will attempt to first conver the given argument to a `Proc` using the `#to_proc` method. 

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

