# Dynamically generate run_autograder.R
cat("
library(jsonlite)
library(ottr)

# Run all tests in the tests directory
results <- ottr::grade_all(test_dir = '/autograder/source/')

# Format results for Gradescope
gradescope_results <- list(
  score = sum(sapply(results$tests, function(x) x$score)),
  tests = lapply(results$tests, function(test) {
    list(
      name = test$name,
      score = test$score,
      max_score = test$max_score,
      output = test$output,
      visibility = ifelse(test$hidden, 'hidden', 'visible')
    )
  })
)

# Write the results to the results.json file
write_json(gradescope_results, '/autograder/results/results.json', pretty = TRUE)
", file = "run_autograder.R")
