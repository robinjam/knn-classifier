module Enumerable

  ##
  # Calculates the sum of all elements.
  #
  # == Examples
  #
  #   [].sum # => 0
  #   [1, 2, 3, 4, 5].sum # => 15

  def sum
    reduce 0, :+
  end

  ##
  # Calculates the mean average of the dataset.
  #
  # == Example
  #
  #   [1, 2, 3, 4, 5].mean # => 3.0

  def mean
    sum / count.to_f
  end

  ##
  # Calculates the variance of the dataset.
  #
  # == Example
  #
  #   [1, 2, 3, 4, 5].variance # => 2.5

  def variance
    # Calculate the mean average a single time rather than once per iteration
    mean = self.mean

    # Calculate (element - mean) ^ 2 for all elements, add the results together and divide by (n - 1)
    map { |element| (element - mean) ** 2 }.sum / (count - 1).to_f
  end

  ##
  # Calculates the standard deviation of the dataset.
  #
  # == Example
  #
  #   [1, 2, 3, 4, 5].standard_deviation # => 1.5811388300841898

  def standard_deviation
    Math.sqrt(variance)
  end

  ##
  # Calculates the euclidean distance between the point represented by self and the point represented by the given enumerable.
  #
  # The two enumerables must be the same size.
  #
  # == Examples
  #
  #   [1].euclidean_distance [5] # => 4.0
  #   [1, 2].euclidean_distance [1, 2] # => 0.0
  #   [1, 2].euclidean_distance [1, 3] # => 1.0

  def euclidean_distance(other)
    # Create an array of pairs by merging each element of self with the corresponding element from other,
    # calculate (a - b) ^ 2 for all pairs, where a is the first element and b is the second element,
    # add the results together and return the square root of the result
    Math.sqrt zip(other).map { |a, b| (a - b) ** 2 }.sum
  end

  ##
  # Returns the nth element of the powerset of this enumerable.
  #
  # == Example
  #
  #   [1, 2, 3].nth_subset(1) # => [1]
  #   [1, 2, 3].nth_subset(2) # => [2]
  #   [1, 2, 3].nth_subset(3) # => [1, 2]

  def nth_subset(n)
    # Ruby allows us to index integers as if they were arrays of bits,
    # so we can check if an element should be included in the result by testing if the ith bit of n is 1
    each_with_index.map { |e, i| e if n[i] == 1 }.compact
  end

end
