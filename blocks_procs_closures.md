# Closures

The concept of a closure in programming is the idea of a chunk of code remembering its surrounding lexical environment even after it executes. This means variables initialized within that chunk of code's lexical environment during execution can be referenced and known by other variables or objects that were returned afterwards from a chunk of codes execution.

Here's an example to demonstrate:

```ruby
def some_method
  x = 0
  Proc.new { |amount| x += amount }
end

proc1 = some_method
proc2 = some_method
proc3 = some_method

p proc1.call(1)   #=> 1
p proc2.call(5)   #=> 5
p proc3.call(100) #=> 100

p proc1.call(1)   #=> 2
p proc2.call(1)   #=> 6
p proc3.call(101) #=>101
```

In the above example we can see that `some_method` returns a new `Proc` object. The block that this `Proc` has, references `x`, a local variable that was defined within `some_method`'s definition as well. Each time `some_method` a new and unique `x` local variable is re-initialized. 

"*Why wouldn't this be re-assignment then?*"

It's not re-assignment because `some_method` initializes a brand new `x` variable everytime it runs. Because of closures, it can't "*remember*" or "*know*" that there's other `x` variables that have been initialized either, there's no conflicts there. Just like how it returns a new `Proc` object each time too. 

For fun, here's a modelling of a Class using methods for instantiation and closures to encapsulate state and behaviour for a given instance:
```ruby
def person_class(name, age)
  class_name = "Person"
  name = name
  age = age

  set_name = Proc.new { |new_name| name = new_name }
  set_age  = Proc.new { |new_age|  age = new_age   }

  Proc.new do |call, arg|
    case call
    when :name  then name
    when :age   then age
    when :name= then set_name.call(arg)
    when :age=  then set_age.call(arg)
    when :instance_of? then class_name
    else self
    end
  end
end

joe = person_class("Joe", 24)
joe.call(:name)           #=> Joe
joe.call(:age)            #=> 24
joe.call(:name=, "Joeyyy")
joe.call(:age=, 25)
joe.call(:name)           #=> Joeyyy
joe.call(:age)            #=> 25
joe.call(:instance_of?)   #=> Person
```

### "Binding"

`Proc` objects and blocks can come in handy when we want to pass a chunk of code into other methods. Why not just store a "chunk of code" as a method definition then? The problem is scoping. If we want our chunk of code to maintain a "memory" of its surrounding lexical environment, then we can't use a method definition beacuse of it's closed-scope. Each time it's invoked, anything that was instantiated or initialized within it, is going to be re-initialized or re-instantiated. It doesn't "hold onto" anything after each execution.

By having objects like a `Proc` that can "*enclose*" its surrounding data and artifacts, we can pass `Proc` objects into methods in order modify or use data that is outside of a method's scope.

In conclusion `Procs` can be useful for passing around chunks of code that need to reference outer-scoped data, or data from anotehr contained lexical environment.

---

---


# Blocks

Blocks are an argument that you pass to methods. This is important to understand. You cannot pass them within the parenthesis though, but they are still considered as an argument to the method in question.

---

---

# Procs

`Procs` are objects that are used to store blocks in Ruby. 

*"Why would we need this?"* 

`Procs` serve 2 purposes:

1. It allows us to save/store blocks. A `Proc` as an object that can be stored in a variable for use to reference and use when we need it. You can't store a *"literal"* block in a variable. 

**Example:**
```ruby
a = [1, 2, 3]
double = Proc.new { |i| i * 2 }
a.map(&double)    # This works - We can pass Procs into a method
a.map!(&double)   # This works too!
a.select(&double) # This works too!
```

As seen in the above example, a `Proc` is just a block but in another form. A form that we can reuse.

2. Building off the last point, by being able to store a block in the form of a `Proc`, an object that can stored in a variable, we can now pass a block of code around our code for reuse.

**Here's an example to demonstrate:**
```ruby
my_proc = Proc.new { |value| puts "Here's a value: #{value}!"}

def method_one(a_proc)
  x = 100
  a_proc.call(x)
end

def method_two(a_proc)
  method_one(a_proc)
end

method_two(my_proc) #=> Here's a value: 100!
```

As seen in the snippet, `my_proc` can now be passed around from method to method. Something we couldn't necessarily do with a block literal. If you tried to store a literal block in a variable an error would be raised. 

So this would not work: `my_var = { puts "I'm a block }`

Hence why we need to have procs. Because this works: `my_var = Proc.new { puts "I'm a block" }`

### The `&` Operator

This operator in Ruby has two main contexts that it is used in:

1. In method definitions

In method definitions, you can prepend `&` to a parameter name. This will convert any block that is passed to the method into a `Proc` object. Using `Proc#call` we can then call the block of code that the `Proc` contains.

2. In method invocation

In method invocations, you can prepend `&` to an argument. This will convert the argument into a block that the method can `yield`. If the object is not a `Proc` then the `#to_proc` method is called on the argument instead. 

