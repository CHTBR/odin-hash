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
  end

  describe "#has?" do
  end

  describe "#remove" do
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
