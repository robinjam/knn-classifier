require 'minitest/autorun'
require 'knn_classifier'

class TestKnnClassifier < MiniTest::Unit::TestCase
  def setup
    @knn = KnnClassifier.new [0, 0] => "A", [5, 5] => "A", [10, 10] => "B", [15, 15] => "B"
  end

  def test_classify
    assert_equal "A", @knn.classify([6, 6], 3)
    assert_equal "B", @knn.classify([9, 9], 3)
  end

  def test_classify_with_tie
    assert_equal "A", @knn.classify([6, 6], 4)
    assert_equal "B", @knn.classify([9, 9], 4)
  end
end
