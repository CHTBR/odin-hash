require "rspec"
require_relative "lib/hash_map"

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
  end

  describe "#clear" do
  end

  describe "#keys" do
  end

  describe "#values" do
  end

  describe "#entries" do
  end
end
