require 'minitest/autorun'
require 'enumerable'

class TestEnumerable < MiniTest::Unit::TestCase
  def setup
    @array = [1, 2, 3, 4, 5]
  end

  def test_sum
    assert_equal 0, [].sum
    assert_equal 15, @array.sum
  end

  def test_mean
    assert_equal 3.0, @array.mean
  end

  def test_variance
    assert_equal 2.5, @array.variance
  end

  def test_standard_deviation
    assert_equal Math.sqrt(2.5), @array.standard_deviation
  end
end
