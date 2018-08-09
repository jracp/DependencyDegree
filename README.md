---
title: "DependencyDegree"
author: "Javad Rahimipour Anaraki"
date: '23/05/18'
---

## Use case
To determine fuzzy rough dependency degree of features based on [New Approaches to Fuzzy-Rough Feature Selection](https://ieeexplore.ieee.org/document/4505335/) which can be used as a fitness function of evolutionary algorithms


## Compile
This code can be run using [MATLAB](https://www.mathworks.com/products/matlab.html) R2006a and above

## Run
To run the code, call `dpendency.m` function with two inputs, address to a dataset and a binary vector with size of features of the dataset. For instance, calling the function with `dependency('Data/wine.csv', [0 0 0 1 0 1 0 1 1 0 0 0 0])` would calculate fuzzy rough dependency degree of selected features {4, 6, 8 ,9} for `wine.csv` dataset.

Datasets can be downloaded from [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/index.php)

## Note
Datasets should have no column and/or row names, and the class values should be all numeric
