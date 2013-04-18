require 'enumerable'

##
# Classifies datapoints using the k-nearest neighbors algorithm.

class KnnClassifier

  ##
  # Creates a KNN classifier with the given data.
  #
  # The data is expected to be a hash in which the keys are arrays representing points and the values are the classification for each point.
  #
  # == Example
  #
  #   @knn = KnnClassifier.new [0, 0] => "A", [5, 5] => "A", [10, 10] => "B", [15, 15] => "B"

  def initialize(data)
    @data = data
  end

  ##
  # Classifies the given point using the data by calculating the nearest k points and selecting the most frequent classification.
  #
  # == Examples
  #
  #   @knn.classify [6, 6], 3 # => "A"
  #   @knn.classify [9, 9], 3 # => "B"

  def classify(point, k)
    # Sort the data based on the euclidean distance from the given point
    @data.sort_by { |datapoint, _| point.euclidean_distance(datapoint) }.

    # Limit to the nearest k datapoints
    first(k).

    # Get the classifications for these points
    map(&:last).

    # Return the most frequent classification
    mode
  end

end
