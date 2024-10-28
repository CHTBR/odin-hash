# Hash map data structure implementation
class HashMap
  attr_accessor :capacity, :load_factor

  def hash(string)
    hash = 0
    prime = 31
    string.each_char { |char| hash = hash * prime + char.ord }
    hash
  end

  def set(key, value)
  end

  def get(key)
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
  end
end
