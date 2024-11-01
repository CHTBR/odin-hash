require "rspec"
require_relative "../lib/hash_map"

RSpec.describe HashMap do
  describe "#hash" do
    it "returns an integer when given a string" do
      expect(subject.hash("abc")).to be_a Integer
    end

    it "returns different integers for different string inputs" do
      expect(subject.hash("abc")).to_not eql subject.hash("def")
    end

    it "returns different integers for string that differ only in letter order" do
      expect(subject.hash("abc")).to_not eql subject.hash("cba")
    end
  end

  describe "#set" do
    it "sets initial capacity to 16" do
      expect(subject.capacity).to eql 16
    end

    it "sets load factor to be between 0.75 and 1" do
      expect(subject.load_factor < 1 && subject.load_factor > 0.75).to eql true
    end

    it "adds the key-value pair to the hash" do
      hash_map = subject
      hash_map.set("key", "value")
      expect(hash_map.entries).to eql [["key", "value"]]
    end

    it "overrides the key-value pair with the newest value" do
      hash_map = subject
      hash_map.set("key", "old value")
      hash_map.set("key", "new value")
      expect(subject.get("key")).to eql "new value"
    end

    it "adds two different key-value pairs even if they have the same hash" do
      hash_map = subject
      hash_map.capacity = 1
      hash_map.load_factor = 3
      hash_map.set("original key", 1)
      hash_map.set("repeating hash", 2)
      expect(hash_map.has?("repeating hash")).to eql true
    end

    context "when given more key-value pairs than load_factor*capacity" do
      it "doubles capacity" do
        hash_map = subject
        init_capacity = hash_map.capacity
        load_factor = hash_map.load_factor
        (init_capacity * load_factor).ceil.times { |key| hash_map.set(key.to_s, key) }
        expect(hash_map.capacity).to eql(init_capacity * 2)
      end
    end
  end

  describe "#get" do
    before do
      @hash_map = subject
      @hash_map.set("a", 1)
      @hash_map.set("b", 2)
      @hash_map.set("c", 3)
      @hash_map.set("d", 4)
    end

    it "returns the value associated with the key a" do
      expect(@hash_map.get("a")).to eql 1
    end

    it "returns the value associated with the key c" do
      expect(@hash_map.get("c")).to eql 3
    end

    it "returns nil when asking for a non-existent key" do
      expect(@hash_map.get("not a key")).to eql nil
    end
  end

  describe "#has?" do
    before do
      @hash_map = subject
      @hash_map.set("is a key", 1)
    end

    it "returns true when asking for an existing key" do
      expect(@hash_map.has?("is a key")).to eql true
    end

    it "returns false when asking for a non-existent key" do
      expect(@hash_map.has?("not a key")).to eql false
    end
  end

  describe "#remove" do
    before do
      @hash_map = subject
      @hash_map.set("a", 1)
      @hash_map.set("b", 2)
      @hash_map.set("c", 3)
      @hash_map.set("d", 4)
    end

    it "returns nil when removing a non-existent key" do
      expect(@hash_map.remove("not a key")).to eql nil
    end

    it "returns the value associated with the key" do
      expect(@hash_map.remove("b")).to eql 2
    end

    it "removes the key-value pair from the hash" do
      @hash_map.remove "d"
      expect(@hash_map.has?("d")).to eql false
    end
  end

  describe "#length" do
    it "returns 0 when hash is empty" do
      hash_map = subject
      expect(hash_map.length).to eql 0
    end

    it "returns 4 when hash contains 4 key-value pairs" do
      num_of_pairs = 4
      hash_map = subject
      num_of_pairs.times { |key| hash_map.set(key.to_s, key) }
      expect(hash_map.length).to eql num_of_pairs
    end

    it "returns 8 when hash contains 8 key-value pairs" do
      num_of_pairs = 8
      hash_map = subject
      num_of_pairs.times { |key| hash_map.set(key.to_s, key) }
      expect(hash_map.length).to eql num_of_pairs
    end

    it "returns 13 when hash contains 13 key-value pairs" do
      num_of_pairs = 13
      hash_map = subject
      num_of_pairs.times { |key| hash_map.set(key.to_s, key) }
      expect(hash_map.length).to eql num_of_pairs
    end
  end

  describe "#clear" do
    it "returns an empty hash when given an empty hash" do
      expect(subject.clear.length).to eql 0
    end

    it "returns an empty hash when given a hash with pairs" do
      hash_map = subject
      5.times { |key| hash_map.set(key.to_s, key) }
      expect(hash_map.clear.length).to eql 0
    end
  end

  describe "#keys" do
    it "returns an empty array when given an empty hash" do
      expect(subject.keys).to eql []
    end

    it "returns [\"a\", \"b\", \"c\", \"d\"] when given a hash with these keys" do
      hash_map = subject
      hash_map.set("a", 1)
      hash_map.set("b", 2)
      hash_map.set("c", 3)
      hash_map.set("d", 4)
      expect(hash_map.keys).to eql %w[a b c d]
    end
  end

  describe "#values" do
    it "returns an empty array when given an empty hash" do
      expect(subject.values).to eql []
    end

    it "returns [1, 2, 3, 4] when given a hash with these values" do
      hash_map = subject
      hash_map.set("a", 1)
      hash_map.set("b", 2)
      hash_map.set("c", 3)
      hash_map.set("d", 4)
      expect(hash_map.values).to eql [1, 2, 3, 4]
    end
  end

  describe "#entries" do
    it "returns an empty array when given an empty hash" do
      expect(subject.entries).to eql []
    end

    it "returns [[\"a\", 1], [\"b\", 2], [\"c\", 3], [\"d\", 4]] when given a hash with these values" do
      hash_map = subject
      hash_map.set("a", 1)
      hash_map.set("b", 2)
      hash_map.set("c", 3)
      hash_map.set("d", 4)
      expect(hash_map.entries).to eql [["a", 1], ["b", 2], ["c", 3], ["d", 4]]
    end
  end
end
