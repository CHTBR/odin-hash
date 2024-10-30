require_relative "linked_list/linked_list"

# Hash map data structure implementation
class HashSet
  attr_accessor :capacity, :load_factor

  def initialize
    @capacity = 16
    @load_factor = 0.8
    @buckets = Array.new(@capacity) { LinkedList.new }
    @size = 0
  end

  def hash(string)
    hash = 0
    prime = 31
    string.each_char { |char| hash = (hash * prime) + char.ord }
    hash
  end

  def set(value)
    hash_code = hash(value)
    bucket_index = hash_code % capacity
    bucket = @buckets[bucket_index]
    unless bucket.contains?(value)
      bucket.append(value)
      @size += 1
    end
    _double_bucket_number if @size > (@capacity * @load_factor)
  end

  def has?(value)
    hash_code = hash(value)
    bucket_index = hash_code % capacity
    bucket = @buckets[bucket_index]
    bucket.contains? value
  end

  def remove(value)
    hash_code = hash(value)
    bucket_index = hash_code % capacity
    bucket = @buckets[bucket_index]
    if bucket.contains? value
      @size -= 1
      list_index = bucket.find value
      return bucket.remove_at(list_index)
    end

    nil
  end

  def length
    @size
  end

  def clear
    @size = 0
    @capacity = 16
    @buckets = Array.new(@capacity) { LinkedList.new }
    self
  end

  def entries
    entries = []
    @buckets.each do |bucket|
      bucket.entries.each { |entry| entries.append entry }
    end
    entries
  end

  private

  def _double_bucket_number
    entries = entries()
    @capacity *= 2
    @size = 0
    @buckets = Array.new(@capacity) { LinkedList.new }
    entries.each { |entry| set entry }
  end
end
