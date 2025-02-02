# Loading packages
install.packages("qcc") # install the qcc: Quality Control Charts package
suppressPackageStartupMessages(library(qcc))

# Generate a dataset with 10 samples of size 4 each
set.seed(123)  # For reproducibility

data <- matrix(
  round(rnorm(40, mean = 50, sd = 2), 2),  # Generate 40 random values simulating real data
  ncol = 4,  # 4 observations per sample
  byrow = TRUE
)

print(data) # view the data

# Creating and plotting X̄ chart
X_chart <- qcc(data, type = "xbar")
plot(X_chart)

# Creating and Plotting R chart
R_chart <- qcc(data, type = "R")
plot(R_chart)

