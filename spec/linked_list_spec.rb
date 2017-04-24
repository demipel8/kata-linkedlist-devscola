require 'spec_helper'

class LinkedList
  UNDEFINED = nil
  NOT_FOUND = nil

  def empty?
    true
  end

  def add(element)
    new_element = Element.new(element)

    if @first_element
      @first_element.attach_next(new_element)
    else
      @first_element = new_element
    end
  end

  def find(criteria)
    @first_element.match(criteria)
  end

  class Element
    def initialize(value)
      @value = value
    end

    def match(criteria)
      return self if @value == criteria
      
      return NOT_FOUND if @next.nil?

      @next.match(criteria)
    end

    def attach_next(element)
      if @next.nil?
        @next = element
      else
        @next.attach_next(element)
      end
    end

    def next
      return NOT_FOUND if @next.nil?
      @next
    end

    def value
      @value
    end
  end
end

describe 'linked list' do
  it 'starts empty' do
    list = LinkedList.new

    result = list.empty?

    expect(result).to be true
  end

  it 'adds elements' do
    list = LinkedList.new

    list.add('ramon')
    result = list.find('ramon').value

    expect(result).to eq('ramon')
  end

  it 'looks for an element that is not the list' do
    list = LinkedList.new

    list.add('vanesa')

    expect(list.find('ramon')).to be_nil
  end

  it 'may add more than one element' do
    list = LinkedList.new

    list.add('ramon')
    list.add('vanesa')
    list.add('iliana')

    expect(list.find('ramon')).to_not be_nil
    expect(list.find('vanesa')).to_not be_nil
    expect(list.find('iliana')).to_not be_nil
  end
end
