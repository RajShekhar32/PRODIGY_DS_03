Task-03
#Build a decision tree classifier to predict whether acustomer will purchase a product or service based on their demographic and behavioral data. Use a dataset such as the Bank Marketing dataset from the UCI Machine Learning Repository.
#Sample Dateset :- https://archive.ics.uci.edu/ml/datasets/Bank+Marketing

#Load the necessary packages and library
install.packages("rpart.plot")
library(rpart)
library(rpart.plot)
library(caret)
library(dplyr)
summary(data)

#Load the data
data<-read.csv("C:\\Users\\user\\OneDrive\\Desktop\\Raj\\Bank.csv")
# Inspect the data
str(data)
summary(data)
data$y<-as.factor(data$y)
# Split the data into training (70%) and testing (30%) sets
set.seed(123) # For reproducibility
train_index<-createDataPartition(data$y, p = 0.7, list = FALSE)
train_data<-data[train_index, ]
test_data<-data[-train_index, ]
# Build the Decision Tree model
#the target variable is y(purchase decision) and the rest are predictors
tree_model<-rpart(y ~ ., data = train_data, method = "class")
# Visualize the Decision Tree
rpart.plot(tree_model)
# Make predictions on the test set
predictions<-predict(tree_model, test_data, type = "class")
# Evaluate the model
confusion_matrix <- confusionMatrix(predictions, test_data$y)
print(confusion_matrix)
#Plot variable importance
importance<-varImp(tree_model)
print(importance)
# Output accuracy
cat("Accuracy: ", confusion_matrix$overall['Accuracy'], "\n")