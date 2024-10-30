require_relative "linked_list/linked_list"

# Hash map data structure implementation
class HashMap
  attr_accessor :capacity, :load_factor

  def initialize
    @capacity = 16
    @load_factor = 0.8
    @buckets = Array.new(@capacity) { LinkedList.new }
  end

  def hash(string)
    hash = 0
    prime = 31
    string.each_char { |char| hash = hash * prime + char.ord }
    hash
  end

  def set(key, value)
    hash_code = hash(key)
    bucket_index = hash_code % capacity
    bucket = @buckets[bucket_index]

    list_index = nil
    bucket.any? do |arr, index|
      if arr[0] == key
        list_index = index
        return true
      end
      false
    end

    if list_index.nil?
      bucket.append([key, value])
    else
      bucket.remove_at(list_index)
      bucket.insert_at(list_index, [key, value])
    end
  end

  def get(key)
    hash_code = hash(key)
    bucket_index = hash_code % @capacity
    bucket = @buckets[bucket_index]
    key_value_pair = bucket.any? { |arr| arr[0] == key ? true : false }
    return key_value_pair[1] unless key_value_pair.nil?

    nil
  end

  def has?(key)
  end

  def remove(key)
  end

  def length
  end

  def clear
  end

  def keys
  end

  def values
  end

  def entries
    entries = []
    @buckets.each do |bucket|
      bucket.entries.each { |entry| entries.append entry }
    end
    entries
  end
end
