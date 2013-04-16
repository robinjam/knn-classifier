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

end
