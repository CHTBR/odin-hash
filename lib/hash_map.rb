require_relative "linked_list/linked_list"

# Hash map data structure implementation
class HashMap
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

  def set(key, value)
    hash_code = hash(key)
    bucket_index = hash_code % capacity
    bucket = @buckets[bucket_index]
    key_value_pair = bucket.any { |arr| arr[0] == key }
    if key_value_pair.nil?
      bucket.append([key, value])
      @size += 1
    else
      list_index = bucket.find key_value_pair
      bucket.remove_at(list_index)
      bucket.insert_at(list_index, [key, value])
    end
    _double_bucket_number if @size > (@capacity * @load_factor)
  end

  def get(key)
    hash_code = hash(key)
    bucket_index = hash_code % @capacity
    bucket = @buckets[bucket_index]
    key_value_pair = bucket.any { |arr| arr[0] == key }
    return key_value_pair[1] unless key_value_pair.nil?

    nil
  end

  def has?(key)
    hash_code = hash(key)
    bucket_index = hash_code % capacity
    bucket = @buckets[bucket_index]
    key_value_pair = bucket.any { |arr| arr[0] == key }
    !key_value_pair.nil?
  end

  def remove(key)
    hash_code = hash(key)
    bucket_index = hash_code % capacity
    bucket = @buckets[bucket_index]
    key_value_pair = bucket.any { |arr| arr[0] == key }
    if key_value_pair.nil?
      return nil
    else
      @size -= 1
      list_index = bucket.find(key_value_pair)
      return bucket.remove_at(list_index)[1]
    end
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

  def keys
    entries.reduce([]) { |acc, entry| acc << entry[0] }
  end

  def values
    entries.reduce([]) { |acc, entry| acc << entry[1] }
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
    entries.each { |entry| set(entry[0], entry[1]) }
  end
end
