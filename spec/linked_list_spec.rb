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

  def remove(element)
    if @first_element.match?(element)
      @first_element = @first_element.next
    else
      parent = @first_element.parent_of(element)
      child = parent.next

      parent.set_next(child.next)
    end
  end

  class Element
    def initialize(value)
      @value = value
      @next = nil
    end

    def match(criteria)
      if match?(criteria)
        self
      else
        match_next(criteria)
      end
    end

    def parent_of(child)
      if @next.match?(child)
        self
      else
        @next.parent_of(child)
      end
    end

    def match?(criteria)
      @value == criteria
    end

    def attach_next(element)
      return @next.attach_next(element) if next?
      @next = element
    end

    def value
      @value
    end

    def next
      @next
    end

    def set_next(new_next)
      @next = new_next
    end

    private

    def match_next(criteria)
      return @next.match(criteria) if next?
      NOT_FOUND
    end

    def next?
      !@next.nil?
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

  it 'removes elements' do
    list = LinkedList.new


    list.add('ramon')
    list.add('vanesa')
    list.remove('vanesa')


    expect(list.find('vanesa')).to be_nil
  end
end
