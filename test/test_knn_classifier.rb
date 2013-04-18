require 'minitest/autorun'
require 'knn_classifier'

describe KnnClassifier do
  before do
    @knn = KnnClassifier.new [0, 0] => "A", [5, 5] => "A", [10, 10] => "B", [15, 15] => "B"
  end

  it "classifies points by calculating nearest neighbours" do
    @knn.classify([6, 6], 3).must_equal "A"
    @knn.classify([9, 9], 3).must_equal "B"
  end

  it "reduces k and tries again if there is a tie" do
    @knn.classify([6, 6], 4).must_equal "A"
    @knn.classify([9, 9], 4).must_equal "B"
  end
end
