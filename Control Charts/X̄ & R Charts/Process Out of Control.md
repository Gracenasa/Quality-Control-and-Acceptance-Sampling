# Generate a data set

```{r}
set.seed(123)
data_outlier <- matrix(
  round(rnorm(40, mean = 50, sd = 2), 2),
  ncol = 4,
  byrow = TRUE
)
print(data_outlier)
```

|   | 1   | 2  | 3  | 4   |
|---|------|------|------|------|
| 1 | 48.88 | 49.54 | 53.12 | 50.14 |
| 2 | 50.26 | 53.43 | 50.92 | 47.47 |
| 3 | 48.63 | 49.11 | 52.45 | 50.72 |
| 4 | 50.80 | 50.22 | 48.89 | 53.57 |
| 5 | 51.00 | 46.07 | 51.40 | 49.05 |
| 6 | 47.86 | 49.56 | 47.95 | 48.54 |
| 7 | 48.75 | 46.63 | 51.68 | 50.31 |
| 8 | 47.72 | 52.51 | 50.85 | 49.41 |
| 9 | 51.79 | 51.76 | 51.64 | 51.38 |
|10 | 51.11 | 49.88 | 49.39 | 49.24 |

## Introduce an outlier in sample 5, observation 2 that will make the process be out of control
```{r}
data_outlier[5, 2] <- 60

```

## Create an X chart
```{r}
X_chart <- qcc(data_outlier, type = "xbar")

```

![image](https://github.com/user-attachments/assets/a0655757-0900-4450-b51e-d9bf69d91726)

## Create an R chart
```{r}
R_chart <- qcc(data_outlier, type = "R")

```
![R chart (i)](https://github.com/user-attachments/assets/06bf54fe-1a44-4e5b-b85e-255b1c2e1390)

From the R chart, we can conclude that the process is not under statistical control even though the Xbar chart is under control.

Thus, we must detect and remove the sample with the outlier and design another control chart

## Detecting the outlier
```{r}
summary(X_chart)
summary(R_chart)

```
![image](https://github.com/user-attachments/assets/f69ba83b-4618-4a4c-b6de-58065fdc91ea)

From our observation, 5 is the sample causing the variation, thus we exclude it and re-do our analysis.

## Remove sample with max observation greater than control limit
```{r}
data_cleaned <- data_outlier[-5,]

```

## Create an X chart
```{r}
X_chart <- qcc(data_cleaned, type = "xbar")

```
![X chart (ii)](https://github.com/user-attachments/assets/2cdd9a36-26da-4439-a4af-205a158d804d)

## Create an R chart
```{r}
R_chart <- qcc(data_cleaned, type = "R")

```
![R chart (ii)](https://github.com/user-attachments/assets/85ddaec5-31d5-4560-ba6d-e0b16403e123)

Our process is now under control and the values obtained from X and R charts can be used as trial limits in the future.


Our method of detecting and removing outliers isn't quite efficient, thus we could make use of a function to detect samples who's observations go beyond the limits, remove the sample and store the cleaned dataset.

```{r}
# Store the control limits
x_chart_limits <- X_chart$limits
R_chart_limits <- R_chart$limits

```
```{r}
# Create a function 
detect_outliers <- function(data, x_chart_limits, R_chart_limits) {
  
  # Calculate subgroup means and ranges
  subgroup_means <- rowMeans(data)  
  subgroup_ranges <- apply(data, 1, function(x) max(x) - min(x))
  
  # Identify subgroups exceeding control limits
  outlier_subgroups <- which(
    (subgroup_means < x_chart_limits[1] | subgroup_means > x_chart_limits[2]) |
      (subgroup_ranges < R_chart_limits[1] | subgroup_ranges > R_chart_limits[2])
  )
  
  return(outlier_subgroups)
}

outlier_indices <- detect_outliers(data_outlier, x_chart_limits, R_chart_limits)

# Remove Outliers
if (length(outlier_indices) > 0) {
  data_cleaned <- data_outlier[-outlier_indices, ]
} else {
  data_cleaned <- data_matrix  # If no outliers, keep original data
}

```

We now have a new dataset called data_cleaned free from outliers.
