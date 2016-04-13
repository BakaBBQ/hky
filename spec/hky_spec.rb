require_relative '../hky.rb'
require 'rspec'

class TestClass
  attr_reader :a
  def initialize
    @a = []
  end

  def modify
    @a << 1
  end

  def modify_with_something sth
    @a << sth
  end
end

describe Hky do
  describe TestClass do
    it 'vanilla should work' do
      tc = TestClass.new
      tc.modify
      expect {tc.a == [1]}
    end
  end

  describe '#def_before' do
    it 'should work' do
      class TestClass
        extend Hky
        def_before :modify do
          @a << 2
        end
      end
      tc = TestClass.new
      tc.modify
  	  expect {tc.a == [2,1]}
    end

    it 'with args' do
      class TestClass
        extend Hky
        def_before :modify_with_something do |a|
          @a << a
        end
      end
      tc = TestClass.new
      tc.modify_with_something 1
      expect {tc.a == [1, 1]}
    end
  end

  describe '#def_after' do
    it 'should work' do
      class TestClass
        extend Hky
        def_after :modify do
          @a << 2
        end
      end
      tc = TestClass.new
      tc.modify
      expect {tc.a == [1,2]}
    end
  end

  describe '#def_around' do
    it 'should work' do
      class TestClass
        extend Hky
        def_around :a do |ori|
          [ori].concat [1,2]
        end

        def_around :a do |ori|
          ori * 2
        end
      end
      tc = TestClass.new
      tc.modify
      expect {tc.a == [1,1,2,1,1,2]}
    end

  end
end
