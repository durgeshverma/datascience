### Introduction

This project assignment demonstrates the learning ability to build machine learning algorithm to predict activity quality from human activity recognition data set.


1. README.md - this file
2. HAR-Analysis.rmd - R markdown file describing the machine learning algorothm and how the final model is selected
3. HAR-Analysis.html - compiled HTML report as the outcome of HAR-Analysis.rmd file. Supplement file HAR-Analysis.pdf is also provided so as HTML file need not be downloaded

### Requirement for project assignment
The goal of your project is to predict the manner in which they did the exercise. This is the "classe" variable in the training set. You may use any of the other variables to predict with. You should create a report describing how you built your model, how you used cross validation, what you think the expected out of sample error is, and why you made the choices you did. You will also use your prediction model to predict 20 different test cases. 

1. Your submission should consist of a link to a Github repo with your R markdown and compiled HTML file describing your analysis.
2. You should also apply your machine learning algorithm to the 20 test cases available in the test data above. Please submit your predictions in appropriate format to the programming assignment for automated grading.

### Raw data
1. The training data for this project are available here: https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv
2. The test data are available here: https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv
3. The data for this project come from this source: http://groupware.les.inf.puc-rio.br/har

### Report Structure
1. Required packages
    - dplyr
    - caret
    - knitr
2. Data Processing
    - clean up data (NA columns)
    - select columns required for analysis as described in the assignment problem ("classe","belt","arm","dumbell")
    - Model 1 - use PCA method for pre processing data to select most important columns, and then feed it to random forest to train data set
    - Model 2 - use center/scale method for pre processing data to select most important columns, and then feed it to random forest to train data set
    - both model define trainControl for cross validations. Each iteration (total 10) is split into 75% training and 25% validation data sets
    - Results are shown at the end of reports that answers all questions asked in assignment problem

### Contributor
	- Student Coursera Data Science Specialization
