module CommonTests
  X = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  Y = [[1, :a], [2, :b], [3, :c], [4, :d]]
  Z = X.map { |x| x * 10 }

  def test_index_first_element
    assert_equal 0, X.binary_index(1)
  end

  def test_index_last_element
    assert_equal 9, X.binary_index(10)
  end

  def test_index_other_elements
    assert_equal 1, X.binary_index(2)
    assert_equal 2, X.binary_index(3)
    assert_equal 3, X.binary_index(4)
    assert_equal 4, X.binary_index(5)
    assert_equal 5, X.binary_index(6)
    assert_equal 6, X.binary_index(7)
    assert_equal 7, X.binary_index(8)
    assert_equal 8, X.binary_index(9)
  end

  def test_index_returns_nil_when_not_found
    assert_nil X.binary_index(-1)
  end

  #
  # with block
  #

  def test_index_without_block_raises_when_0_arguments_provided
    assert_raises(ArgumentError) {
      X.binary_index
    }
  end

  def test_index_without_block_raises_when_2_arguments_provided
    assert_raises(ArgumentError) {
      X.binary_index(1, 2)
    }
  end

  def test_index_block_raises_when_argument_also_provided
    assert_raises(ArgumentError) {
      X.binary_index(1) { |x| 4 <=> x }
    }
  end

  def test_index_block_first_element
    assert_equal 0, X.binary_index { |x| 1 <=> x }
  end

  def test_index_block_last_element
    assert_equal 9, X.binary_index { |x| 10 <=> x }
  end

  def test_index_block_other_elements
    assert_equal 1, X.binary_index { |x| 2 <=> x }
    assert_equal 2, X.binary_index { |x| 3 <=> x }
    assert_equal 3, X.binary_index { |x| 4 <=> x }
    assert_equal 4, X.binary_index { |x| 5 <=> x }
    assert_equal 5, X.binary_index { |x| 6 <=> x }
    assert_equal 6, X.binary_index { |x| 7 <=> x }
    assert_equal 7, X.binary_index { |x| 8 <=> x }
    assert_equal 8, X.binary_index { |x| 9 <=> x }
  end

  def text_index_block_returns_nil_when_not_found
    assert_nil X.binary_index { |x| -1 <=> x }
  end

  #
  # binary_search
  #

  def test_search_first_element
    assert_equal ([1, :a]), Y.binary_search { |v| 1 <=> v[0] }
  end

  def test_search_last_element
    assert_equal ([4, :d]), Y.binary_search { |v| 4 <=> v[0] }
  end

  def test_search_other_elements
    assert_equal ([2, :b]), Y.binary_search { |v| 2 <=> v[0] }
    assert_equal ([3, :c]), Y.binary_search { |v| 3 <=> v[0] }
  end

  def test_search_returns_nil_when_not_found
    assert_nil Y.binary_search { |v| -1 <=> v[0] }
  end

  #
  # binary_index_approximate
  #
  def text_approximate_first_element
    assert_equal 0, Z.binary_index_approximate(10)
  end

  def text_approximate_last_element
    assert_equal 9, Z.binary_index_approximate(100)
  end

  def text_approximate_other_elements
    assert_equal 0, Z.binary_index_approximate(15)
    assert_equal 1, Z.binary_index_approximate(20)
    assert_equal 1, Z.binary_index_approximate(25)
    assert_equal 2, Z.binary_index_approximate(30)
    assert_equal 3, Z.binary_index_approximate(40)
    assert_equal 4, Z.binary_index_approximate(50)
    assert_equal 5, Z.binary_index_approximate(60)
    assert_equal 6, Z.binary_index_approximate(70)
    assert_equal 7, Z.binary_index_approximate(80)
    assert_equal 8, Z.binary_index_approximate(90)
  end

  def text_approximate_returns_negative_one_when_before_first_entry
    assert_equal -1, Z.binary_index_approximate(1)
  end

  def test_approximate_returns_size_minus_one_when_after_last_entry
    assert_equal Z.size - 1, Z.binary_index_approximate(1000)
  end

end
