require 'minitest/autorun'

# Implementation

class PaginationHelper
  def initialize(collection, per_page)
    @collection = collection
    @per_page = per_page
  end

  def page_count
    (item_count / @per_page.to_f).ceil
  end

  def item_count
    @collection.size
  end

  def page_item_count(page)
    return -1 unless (0...page_count).cover?(page)
    [@per_page, (item_count - page * @per_page).abs].min
  end

  def page_index(item_index)
    return -1 unless (0...item_count).cover?(item_index)
    item_index / @per_page
  end
end

# Tests

describe 'PaginationHelper' do
  let(:collection) { ('a'..'y').to_a } # 25 elements
  let(:per_page) { 4 }
  subject { PaginationHelper.new(collection, per_page) }

  describe '.item_count' do
    it 'should return items count' do
      subject.item_count.must_equal 25
    end
  end

  describe '.page_count' do
    it 'should return pages count' do
      subject.page_count.must_equal 7
    end
  end

  describe '.page_item_count' do
    it 'should return number of elements on given page' do
      subject.page_item_count(0).must_equal 4
      subject.page_item_count(2).must_equal 4
      subject.page_item_count(6).must_equal 1
    end

    it 'should return -1 for invalid page number' do
      subject.page_item_count(10).must_equal -1
      subject.page_item_count(7).must_equal -1
      subject.page_item_count(-1).must_equal -1
    end
  end

  describe '.page_index' do
    it 'should return page number given item index belongs to' do
      subject.page_index(0).must_equal 0
      subject.page_index(4).must_equal 1
    end

    it 'should return -1 for invalid item index' do
      subject.page_index(30).must_equal -1
      subject.page_index(25).must_equal -1
      subject.page_index(-1).must_equal -1
    end
  end
end
