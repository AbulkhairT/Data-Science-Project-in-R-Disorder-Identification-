# cs699 project , Wentao Li, Abulkhair Turmakhanov
library(caret)
library(Boruta)
library(FSelector)
library(e1071) # For SVM
library(randomForest)
library(gbm)
library(dplyr)
library(ROSE)


df <- read.csv("~/Downloads/preprocessed_data.csv")

## Clean Data 
# number of missing values in the whole dataset
sum(is.na(df))

# missing values in individual columns
sapply(df, function(x) sum(is.na(x)))

# Replace empty strings with NA in all columns
df[df == ""] <- NA

# removes duplicates 
df_clean <- df %>%
  distinct()

# near zero variance
nearZeroVar(df, names = TRUE)

# Identify variables with near-zero variance
nzv <- nearZeroVar(df, names = TRUE)

# Remove variables with near-zero variance from the dataframe
df_clean <- df[, !names(df) %in% nzv] 

missing_percentage <- sapply(df, function(x) sum(is.na(x)) / length(x)) * 100

# Identify columns with less than 80% missing values
cols_to_keep <- names(missing_percentage[missing_percentage < 80])

# Subset the dataframe to keep only the identified columns
df_clean <- df[, cols_to_keep]

# replace NA with mean 
numeric_columns <- sapply(df_clean, is.numeric)
df_clean[numeric_columns] <- lapply(df_clean[numeric_columns], function(x) {
  if(any(is.na(x))) x[is.na(x)] <- mean(x, na.rm = TRUE)
  x
})

str(df_clean$Class)
df_clean$Class <- as.factor(df_clean$Class)

table(df_clean$Class)




results <- list()

# Balancing Methods
balance_methods <- list(
  oversample = function(data) ovun.sample(Class ~ ., data = data, method = "over")$data,
  undersample = function(data) ovun.sample(Class ~ ., data = data, method = "under")$data
)

# Feature Selectors
feature_selectors <- list(
  Boruta = function(data) {
    boruta_output <- Boruta(Class ~ ., data = data, doTrace = 0)
    selected_features <- getSelectedAttributes(boruta_output, withTentative = FALSE)
    data[, c("Class", selected_features)]
  },
  InformationGain = function(data) {
    info_gain <- information.gain(Class ~ ., data)
    top_n_features <- cutoff.k(info_gain, 5) 
    subset(data, select = c("Class", names(top_n_features)))
  },
  RFE = function(data) {
    control <- rfeControl(functions=rfFuncs, method="cv", number=10)
    rfe_output <- rfe(data[, -which(names(data) == "Class")], data$Class, sizes=c(1:10), rfeControl=control)
    selected_features <- predictors(rfe_output)
    data[, c("Class", selected_features)]
  }
)

classifiers <- list(
  SVM = function(train, test) {
    model <- svm(Class ~ ., data = train)
    predictions <- predict(model, test)
    confusionMatrix(as.factor(predictions), test$Class)
  },
  RandomForest = function(train, test) {
    model <- randomForest(Class ~ ., data = train)
    predictions <- predict(model, test)
    confusionMatrix(as.factor(predictions), test$Class)
  },
  GBM = function(train, test) {
    train$Class <- ifelse(train$Class == "Y", 1, 0)
    test$Class_original <- test$Class 
    test$Class <- ifelse(test$Class == "Y", 1, 0)
    
    # Fit the GBM model
    model <- gbm(Class ~ ., data = train, distribution = "bernoulli", n.trees = 100, verbose = FALSE)
    predictions <- predict(model, test, n.trees = 100, type = "response")
    predictions_binary <- ifelse(predictions > 0.5, 1, 0)
    predictions_factor <- factor(ifelse(predictions_binary == 1, "Y", "N"), levels = c("N", "Y"))
    confusionMatrix(predictions_factor, test$Class_original)
  },
  LogisticRegression = function(train, test) {
    model <- glm(Class ~ ., data = train, family = "binomial")
    predictions_prob <- predict(model, test, type="response")
    predictions_class <- ifelse(predictions_prob > 0.5, "Y", "N")
    cm <- confusionMatrix(as.factor(predictions_class), as.factor(test$Class))
    roc_result <- roc(response = test$Class, predictor = as.numeric(predictions_prob), levels = c("N", "Y"))
    auc_result <- auc(roc_result)
    return(list(confusion_matrix = cm, ROC = roc_result, AUC = auc_result))
  },
  DecisionTree = function(train, test) {
    model <- rpart(Class ~ ., data = train, method="class")
    predictions <- predict(model, test, type = "prob")
    highest_prob <- apply(predictions, 1, which.max)
    predictions_class <- levels(train$Class)[highest_prob]
    cm <- confusionMatrix(as.factor(predictions_class), as.factor(test$Class))
    
    roc_result <- roc(response = test$Class, predictor = predictions[,2], levels = c("N", "Y"))
    auc_result <- auc(roc_result)
    return(list(confusion_matrix = cm, ROC = roc_result, AUC = auc_result))
  },
  NaiveBayes = function(train, test) {
    model <- naiveBayes(Class ~ ., data = train)
    predictions_prob <- predict(model, test, type = "raw")
    predictions_class <- ifelse(predictions_prob[,2] > 0.5, "Y", "N")
    cm <- confusionMatrix(as.factor(predictions_class), as.factor(test$Class))
    roc_result <- roc(response = test$Class, predictor = predictions_prob[,2], levels = c("N", "Y"))
    auc_result <- auc(roc_result)
    return(list(confusion_matrix = cm, ROC = roc_result, AUC = auc_result))
  }
)


df_clean$Class <- factor(df_clean$Class, levels = c("N", "Y"))

# Execution loop
result_index <- 1
for (balance_name in names(balance_methods)) {
  for (selector_name in names(feature_selectors)) {
    for (classifier_name in names(classifiers)) {
      print(paste("Running combination:", balance_name, selector_name, classifier_name))
      
      # Balancing
      balanced_data <- balance_methods[[balance_name]](df_clean)
      
      # Check for NA in Class column after balancing
      if (any(is.na(balanced_data$Class))) {
        stop("NAs detected in the target variable after balancing with ", balance_name)
      }
      
      # Feature Selection
      selected_data <- feature_selectors[[selector_name]](balanced_data)
      
      selected_data <- feature_selectors[["Boruta"]](df_clean)
      selected_data <- as.data.frame(selected_data)
      
      # Check for NA in Class column after feature selection
      if (any(is.na(selected_data$Class))) {
        stop("NAs detected in the target variable after feature selection with ", selector_name)
      }
      
      # Splitting the data
      indexes <- createDataPartition(selected_data$Class, p=0.8, list=FALSE)
      train_data <- selected_data[indexes, ]
      test_data <- selected_data[-indexes, ]
      

      train_data <- as.data.frame(train_data)
      test_data <- as.data.frame(test_data)
      
      
      # Check for NA in Class column after split
      if (any(is.na(train_data$Class))) {
        stop("NAs detected in the target variable of the training set")
      }
      if (any(is.na(test_data$Class))) {
        stop("NAs detected in the target variable of the testing set")
      }
      
      # Classification
      cm <- classifiers[[classifier_name]](train_data, test_data)
      
      # Storing results
      results[[length(results) + 1]] <- list(
        balance_method = balance_name,
        feature_selector = selector_name,
        classifier = classifier_name,
        confusion_matrix = cm
      )
    }
  }
}

# Displaying results
results