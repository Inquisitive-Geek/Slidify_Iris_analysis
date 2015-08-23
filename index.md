---
title       : Iris Analysis And Prediction
subtitle    : Prediction of Species using glmnet
author      : Roshan Shetty
job         : Intern at SAP, Budding Data Scientist
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Motivation

1. Iris features are a good indicator of species
2. Dataset is available which can be used for prediction
3. Helps anyone interested to collect new data and make predictions

--- .class #id 

## Analysis

Iris summary gives indication of range of inputs to be used

```r
summary(iris)
```

```
##   Sepal.Length    Sepal.Width     Petal.Length    Petal.Width   
##  Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100  
##  1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300  
##  Median :5.800   Median :3.000   Median :4.350   Median :1.300  
##  Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199  
##  3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800  
##  Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500  
##        Species  
##  setosa    :50  
##  versicolor:50  
##  virginica :50  
##                 
##                 
## 
```

---

## Model

1. A glmnet model is used for predicting the species of the data

```r
cv.fit <- cv.glmnet(as.matrix(iris[,-5]), 
                    iris[,5], alpha=0.8, 
                    family="multinomial")
```

2. The predict function helps in predicting new values

```r
  species <- predict(cv.fit, 
                        newx=as.matrix(test),
                        type="class")
```

--- 

## Application UI
The following UI will be visible to the user. Note that this does not run the prediction here.
<div class="row-fluid">
  <div class="col-sm-4">
    <form class="well">
      <div class="form-group shiny-input-container">
        <label for="Sepal.Length">Sepal Length</label>
        <input id="Sepal.Length" type="number" class="form-control" value="5" min="4.3" max="7.9" step="0.1"/>
      </div>
      <div class="form-group shiny-input-container">
        <label for="Sepal.Width">Sepal Width</label>
        <input id="Sepal.Width" type="number" class="form-control" value="2.5" min="2" max="4.4" step="0.1"/>
      </div>
      <div class="form-group shiny-input-container">
        <label for="Petal.Length">Petal Length</label>
        <input id="Petal.Length" type="number" class="form-control" value="2" min="1" max="6.9" step="0.1"/>
      </div>
      <div class="form-group shiny-input-container">
        <label for="Petal.Width">Petal Width</label>
        <input id="Petal.Width" type="number" class="form-control" value="1" min="0.1" max="2.5" step="0.1"/>
      </div>
      <div>
        <button type="submit" class="btn btn-primary">Submit</button>
      </div>
    </form>
  </div>
  <div class="col-sm-8">
    <h3>Results of prediction</h3>
    <h4>You entered</h4>
    <p>Sepal Length</p>
    <div id="sepalLen" class="shiny-text-output"></div>
    <p>Sepal Width</p>
    <div id="sepalWid" class="shiny-text-output"></div>
    <p>Petal Length</p>
    <div id="petalLen" class="shiny-text-output"></div>
    <p>Petal Width</p>
    <div id="petalWid" class="shiny-text-output"></div>
    <h4>Which results in a prediction of </h4>
    <div id="Species" class="shiny-text-output"></div>
  </div>
</div>


