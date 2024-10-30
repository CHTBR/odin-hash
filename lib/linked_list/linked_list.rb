require_relative "node"

class EmptyList < StandardError
  def initialize(msg = "Can't perform operation on an empty list")
    super
  end
end

class IndexOutOfRange < StandardError
  def initialize(msg = "Can't perform operation on a nonexistent element")
    super(msg)
  end
end

# A class for managing a linked list DS and containing related methods
class LinkedList
  attr_accessor :head_address, :size

  def initialize(*args)
    @size = 0
    return unless args[0]

    initial_args = args[0]
    @size = initial_args.size
    @head_address = Node.new(initial_args[0])
    current_node = head_address
    initial_args[1..].each do |element|
      new_node = Node.new(element)
      current_node.next_address = new_node
      current_node = new_node
    end
  end

  def to_s
    return "nil" if head_address.nil?

    data_arr = []
    current_node = head_address
    until current_node.nil?
      data_arr << current_node.data
      current_node = current_node.next_address
    end
    data_arr << "nil"
    data_arr.join(" -> ")
  end

  def tail
    return nil if head_address.nil?

    last_node = _traverse
    last_node.data
  end

  def head
    return nil if head_address.nil?

    head_address.data
  end

  def append(data)
    @size += 1
    new_node = Node.new(data)
    if head_address.nil?
      @head_address = new_node
      return
    end

    last_node = _traverse
    last_node.next_address = new_node
  end

  def list_prepend(data)
    @size += 1
    new_node = Node.new(data)
    new_node.next_address = head_address
    @head_address = new_node
  end

  def at(index)
    raise TypeError unless index.instance_of? Integer
    return nil if index >= size

    _traverse(index).data
  end

  def pop
    raise EmptyList.new("Can't perform pop on an empty list") unless head_address

    before_last_node = _traverse(size - 2)
    last_node = before_last_node.next_address
    before_last_node.next_address = nil
    @size -= 1
    last_node.data
  end

  def contains?(value)
    return false if head_address.nil?

    current_node = head_address
    current_node = current_node.next_address until current_node.data == value || current_node.next_address.nil?
    return true if current_node.data == value

    false
  end

  def find(value)
    return nil if head_address.nil?

    current_node = head_address
    index = 0
    until current_node.data == value || current_node.next_address.nil?
      current_node = current_node.next_address
      index += 1
    end
    return index if current_node.data == value

    nil
  end

  def insert_at(index, value)
    @size += 1
    if head_address.nil?
      append(value)
    else
      new_node = Node.new(value)
      node_before_index = _traverse(index - 1)
      new_node.next_address = node_before_index.next_address
      node_before_index.next_address = new_node
    end
  end

  def remove_at(index)
    raise EmptyList.new("Can't remove elements from an empty list") if head_address.nil?
    raise IndexOutOfRange.new("Can't remove nonexistent element") unless index < size
    @size -= 1
    if index.zero?
      deleted_node = head_address
      @head_address = @head_address.next_address
    else
      node_before_index = _traverse(index - 1)
      deleted_node = node_before_index.next_address
      node_before_index.next_address = node_before_index.next_address.next_address
    end
    deleted_node.data
  end

  def any?
    return false if head.nil?

    index = 0
    current_node = @head_address
    until current_node.next_address.nil?
      return true if yield(current_node.data, index)

      current_node = current_node.next_address
      index += 1
    end
    return true if yield current_node.data

    false
  end

  def entries
    entries = []

    unless @head_address.nil?
      current_node = @head_address
      until current_node.next_address.nil?
        entries.append(current_node.data)
        current_node = current_node.next_address
      end
      entries.append(current_node.data)
    end
    entries
  end

  private

  def _traverse(*optional_index)
    index = optional_index[0] || -1
    current_node = head_address
    until current_node.next_address.nil? || index.zero?
      current_node = current_node.next_address
      index -= 1
    end
    current_node
  end
end
