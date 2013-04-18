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
  lines.map! do |point, classification|
    [point.each_with_index.map { |e, i| (e - means[i]) / standard_deviations[i] }, classification]
  end

  [lines, variables]
end

def main
  # Read the dive data
  lines, variables = read_data("diveData.txt")

  # Output a CSV file showing the accuracy of the classifier with different values of k
  puts "k,Variables,Accuracy"

  # Try all possible combinations of variables
  1.upto(2 ** variables.count - 1) do |n|
    # Try values from 1-10 for k (larger values typically produce poor results)
    1.upto(10) do |k|
      accuracy = lines.map do |point, classification|
        # Filter the current point from the dataset
        filtered_lines = lines.reject { |p, _| p == point }.

        # Exclude variables we're not using
        # Ruby allows us to index integers as if they were arrays of bits,
        # so we can check if a variable should be used by testing if the ith bit of n is 1
        map { |line| [line.first.each_with_index.map { |e, i| e if n[i] == 1 }.compact, line.last] }

        # Create a KNN classifier using the filtered set
        knn = KnnClassifier.new(filtered_lines)

        point = point.each_with_index.map { |e, i| e if n[i] == 1 }.compact

        # Check if the classification was correct
        knn.classify(point, k) == classification
      end.count(true) / lines.count.to_f

      vars = 1.upto(variables.count).each_with_index.map { |e, i| e if n[i] == 1 }.compact.join(" ")
      puts "#{k},#{vars},#{accuracy}"
      $stdout.flush
    end
  end
end

if __FILE__ == $0
  main
end
