# Loading packages
```{r}
# install the qcc: Quality Control Charts package
install.packages("qcc")

# load the package
library(qcc)

```

```{r}
# Generate a dataset with 10 samples of size 4 each
set.seed(123)  # For reproducibility

data <- matrix(
  round(rnorm(40, mean = 50, sd = 2), 2),  # Generate 40 random values simulating real data
  ncol = 4,  # 4 observations per sample
  byrow = TRUE
)

print(data) # view the data
```

# Creating X̄ chart
```{r}
X_chart <- qcc(data, type = "xbar")

```
![Xbar Chart for a process under control](https://github.com/user-attachments/assets/ffda37f6-62ac-42be-a4f1-e637923b001a)


# Creating and Plotting R chart
```{r}
R_chart <- qcc(data, type = "R")

```
![R chart for a process under control](https://github.com/user-attachments/assets/0696a34c-4460-4b81-a20c-8ace943fb377)

# OC Curve for X̄ chart
```{r}
beta = oc.curves.xbar(X_chart)

```
![OC curve for X bar](https://github.com/user-attachments/assets/dd05dd60-da9f-43fe-ad0a-9beae8e8f94d)

# OC Curve for R chart
```{r}
beta = oc.curves.R(R_chart)

```
![OC curve for R](https://github.com/user-attachments/assets/91e755f4-a654-4f78-bd6e-3137ff5f7cab)


# Observations and Intepretation
For the X̄ chart, the UCL = 53.60583 and the LCL =  47.27217. 

For the R chart, the UCL = 9.91942 and the LCL = 0. These are our trial limits.

The X̄ chart shows that the mean of all sample points used lie within the trial limits. (Detecting changes in the process average mean)

The R chart shows that the range of all sample points used lie within the trial limits. (Detecting changes in the process variabilty)

The OC curves for X̄ and R charts, provide information about the probability of not detecting a shift in the process.

# Remarks
From the X̄ and R charts, the process of production is under statistical control since their is no point that lies outside the control limits

