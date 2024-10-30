# Class for containing data and next address needed for linked list DS
class Node
  attr_reader :data
  attr_accessor :next_address

  def initialize(data)
    @data = data
  end
end
