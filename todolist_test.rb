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

    @sample_todo = Todo.new("Brush Teeth")

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
    assert_equal(@todo1, @list.shift)
    refute_includes(@list.to_a, @todo1)
  end

  def test_pop
    assert_equal(@todo3, @list.pop)
    refute_includes(@list.to_a, @todo3)
  end

  def test_done?
    refute(@list.done?)
  end

  def test_type_error
    assert_raises(TypeError) { @list << 1 }
    assert_raises(TypeError) { @list << "hello" }
  end

  def test_shovel
    @list << @sample_todo
    @todos << @sample_todo
    assert_equal(4, @list.size)
    assert_equal(@list.last, @sample_todo)
    assert_equal(@todos, @list.to_a)
  end

  def test_shovel
    @list.add(@sample_todo)
    @todos << @sample_todo
    assert_equal(4, @list.size)
    assert_equal(@list.last, @sample_todo)
    assert_equal(@todos, @list.to_a)
  end

  def test_item_at
    assert_equal(@todo2, @list.item_at(1))
    assert_equal(@todo1, @list.item_at(0))
    assert_raises(IndexError) { @list.item_at(10) }
  end

  def test_mark_done_at
    @list.mark_done_at(1)
    
    assert(@todo2.done?)
    refute(@todo1.done?)
    assert_raises(IndexError) { @list.mark_done_at(10) }
  end

  def test_mark_undone_at
    @list.done!
    @list.mark_undone_at(1)

    refute(@todo2.done?)
    assert(@todo1.done?)
    assert_raises(IndexError) { @list.mark_undone_at(10) }
  end

  def test_done!
    @list.done!
    @todos.each { |todo| assert(todo.done?) }
  end

  def test_remove_at
    @list.remove_at(1)
    assert_equal([@todo1, @todo3], @list.to_a)
    assert_raises(IndexError) { @list.remove_at(10) }
  end

  

end