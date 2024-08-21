class Todo
  DONE_MARKER   = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done
  
  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def undone!
    self.done = false
  end

  def toggle!
    self.done = !done
  end

  def done?
    done
  end

  def to_s
    "[#{marker}] #{title}"
  end

  def ==(other_todo)
    done  == other_todo.done &&
    title == other_todo.title &&
    description == other_todo.description
  end

  private

  def marker
    done ? DONE_MARKER : UNDONE_MARKER
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(*new_todos)
    if new_todos.all? { |todo| todo.instance_of? Todo }
      @todos += new_todos
    else
      raise TypeError, "Can only pass Todo objects."
    end
  end

  def <<(new_todo)
    add(new_todo)
  end

  def size
    todos.size
  end

  def first
    todos.first
  end

  def last
    todos.last
  end

  def to_a
    todos.clone
  end

  def done?
    todos.all? { |todo| todo.done? }
  end

  def item_at(index)
    if index.abs >= todos.size 
      raise IndexError, "Index out of range"
    else
      todos[index]
    end
  end

  def mark_done_at(index)
    if index.abs >= todos.size 
      raise IndexError, "Index out of range"
    else
      todos[index].done!
      todos[index]
    end
  end

  def mark_undone_at(index)
    if index.abs >= todos.size 
      raise IndexError, "Index out of range"
    else
      todos[index].undone!
      todos[index]
    end
  end

  def done!
    todos.each { |todo| todo.done! }
  end

  def undone!
    todos.each { |todo| todo.undone! }
  end

  def to_s
    string_todos = todos.map { |todo| todo.to_s }.join("\n")
    "---- Today's Todos ----\n" + string_todos
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def remove_at(index)
    if index.abs >= todos.size 
      raise IndexError, "Index out of range"
    else
      todos.delete_at(index)
    end
  end

  def each(&block)
    counter = 0
    while counter < size do
      block.call(todos[counter])
      counter += 1
    end

    self
  end

  def select(&block)
    selected = TodoList.new(title)

    each do |todo| 
      selected << todo if block.call(todo) 
    end

    selected
  end

  def find_by_title(title_searched)
    title_found = nil

    each do |todo|
      if todo.title == title_searched
        title_found = todo
        break
      end
    end

    title_found
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_done
    select { |todo| !todo.done? }
  end

  def mark_done(todo_title)
    each { |todo| todo.done! if todo.title == todo_title }
  end

  def mark_all_done
    each { |todo| todo.done! }
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end

  private

  attr_reader :todos
end