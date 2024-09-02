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