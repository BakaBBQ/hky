require_relative '../hky.rb'
require 'rspec'

class TestClass
  attr_reader :a
  def initialize
    @a = []
  end

  def modify
    @a << [1]
  end
end

describe Hky do
  describe TestClass do
    it 'vanilla should work' do
      tc = TestClass.new
      tc.modify
      tc.a == [1]
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
  	  tc.a == [2,1]
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
      tc.a == [1,2]
    end
  end

  describe '#def_around' do
    it 'should work' do
      class TestClass
        extend Hky
        def_around :a do |ori|
          ori.concat [1,2]
        end

        def_around :a do |ori|
          ori * 2
        end
      end
    end
    tc = TestClass.new
    tc.modify
    tc.a == [1,1,2,1,1,2]
  end
end
