require 'knn_classifier'

def read_data(filename)
  # Read the dive data
  lines = File.read("diveData.txt").

  # Split the data into an array of lines
  split("\n").

  # Remove the first line
  tap(&:shift).

  # Split each line into an array of words
  map(&:split).

  # Create an array of pairs, where the first element is a data point and the second element is its classification
  map { |line| [line.pop, line.map(&:to_f)].reverse }

  # Create an array of variables (the columns from the data file) so we can do some stats on them
  variables = lines.map(&:first).transpose

  # Calculate the mean and standard deviation for each variable
  means = variables.map(&:mean)
  standard_deviations = variables.map(&:standard_deviation)

  # Normalize the data by subtracting the mean and dividing by the standard deviation, and return the result
  lines.map do |point, classification|
    [point.each_with_index.map { |e, i| (e - means[i]) / standard_deviations[i] }, classification]
  end
end

def main
  # Read the dive data
  lines = read_data("diveData.txt")

  # Output a CSV file showing the accuracy of the classifier with different values of k
  puts "k,Accuracy"
  1.upto(lines.count) do |k|
    accuracy = lines.map do |point, classification|
      # Create a KNN classifier, excluding the current point from the dataset
      knn = KnnClassifier.new(lines.reject { |p, _| p == point })

      # Check if the classification was correct
      knn.classify(point, k) == classification
    end.count(true) / lines.count.to_f

    puts "#{k},#{accuracy}"
    $stdout.flush
  end
end

if __FILE__ == $0
  main
end
