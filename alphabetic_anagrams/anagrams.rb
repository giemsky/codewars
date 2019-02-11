require 'minitest/autorun'

# IMPLEMENTATION

def position(word)
  return 1 if word.length == 1

  chars = Hash[word.chars.uniq.map{ |c| [c, word.count(c)] }]
  chars.keys.select { |char| char < word[0] }
    .map { |char| chars.dup.tap{|cc| cc[char] > 1 ? cc[char] -= 1 : cc.delete(char) } }
    .sum { |new_chars| count_permutations(new_chars) } + position(word[1..-1])
end

def count_permutations(char_counts)
  factorial(char_counts.values.sum) / char_counts.values.map{|count| factorial(count)}.inject(:*)
end

def factorial(n)
  (1..n).inject(:*)
end

# TESTS

describe('Anagram') do
  it('Must return appropriate values for known inputs') do
    testValues = {'A' => 1, 'ABAB' => 2, 'AAAB' => 1, 'BAAA' => 4, 'QUESTION' => 24572, 'BOOKKEEPER' => 10743}
    testValues.each do |key,value|
      assert_equal(position(key), value, 'Incorrect list position for: ' + key)
    end
  end
end
