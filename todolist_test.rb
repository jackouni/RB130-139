require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'todo_list'

class TodoListTest < Minitest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  # Your tests go here. Remember they must start with "test_"
  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    shifted_todo = @list.shift
    assert_equal(@todo1, shifted_todo)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    popped_todo = @list.pop
    assert_equal(@todo3, popped_todo)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done_question
    assert_equal(false, @list.done?)
    @list.done!
    assert_equal(true, @list.done?)
  end

  def test_add
    new_todo = Todo.new("Sample Todo")
    @list.add(new_todo)
    @todos << new_todo
    assert_equal(@todos, @list.to_a)
  end

  def test_shovel
    new_todo = Todo.new("Sample Todo")
    @list << new_todo
    @todos << new_todo
    assert_equal(@todos, @list.to_a)
  end

  def test_item_at
    todo_at = @list.item_at(1)
    assert_equal(todo_at, @todo2)
    assert_raises(IndexError) { @list.item_at(3) }
  end

  def test_add_raise_error
    assert_raises(TypeError) { @list.add(1) }
    assert_raises(TypeError) { @list.add('hi') }
  end

  def test_mark_done_at
    marked_todo = @list.mark_done_at(1)
    assert_equal(marked_todo.done?, true)
    assert_raises(IndexError) { @list.item_at(3) }
  end
  
  def test_mark_undone_at
    unmarked_todo = @list.mark_undone_at(1)
    assert_equal(unmarked_todo.done?, false)
    assert_raises(IndexError) { @list.item_at(3) }
  end
  
  def test_done!
    @list.done! 
    @list.each do |todo|
      assert_equal(todo.done?, true)
    end
    assert_equal(@list.done?, true)
  end

  def test_remove_at
    removed_todo = @list.remove_at(1)
    assert_equal(removed_todo, @todo2)
    assert_equal([@todo1, @todo3], @list.to_a)
    assert_raises(IndexError) { @list.remove_at(500) }
  end

  def test_to_s
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_2
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT

    @list.mark_done_at(1)
    assert_equal(output, @list.to_s)
  end

  def test_each
    counter = 0

    @list.each do |todo|
      assert_equal(@todos[counter], todo)
      counter += 1
    end
  end

  def test_each_return
    assert_equal(@list, @list.each { |todo| })
  end


  def test_select
    @todo1.done!
    list = TodoList.new(@list.title)
    list.add(@todo1)

    assert_equal(list.title, @list.title)
    assert_equal(list.to_s, @list.select{ |todo| todo.done? }.to_s)
  end
end