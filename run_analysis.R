library(dplyr)

# 1. Setup and Data Acquisition (No auto-download/unzip for stability)
data_path <- "UCI HAR Dataset"

# NOTE: Since automated unzip often fails in the environment, we assume 
# the user has run: unzip("UCI_HAR_Data.zip", exdir = ".") manually.
# We use normalizePath to ensure the correct absolute path is used for reading.
absolute_data_path <- normalizePath(data_path)

# 2. Read Data and Labels (Using the Absolute Path for Reliability)
# *******************************************************************
# Step 4: Appropriately labels the data set with descriptive variable names.
# *******************************************************************
features <- read.table(file.path(absolute_data_path, "features.txt"), header = FALSE)
activity_labels <- read.table(file.path(absolute_data_path, "activity_labels.txt"), header = FALSE)

X_train <- read.table(file.path(absolute_data_path, "train", "X_train.txt"), header = FALSE)
# FIX: Changed Y_train.txt to y_train.txt
Y_train <- read.table(file.path(absolute_data_path, "train", "y_train.txt"), header = FALSE)
Subject_train <- read.table(file.path(absolute_data_path, "train", "subject_train.txt"), header = FALSE)

X_test <- read.table(file.path(absolute_data_path, "test", "X_test.txt"), header = FALSE)
# FIX: Changed Y_test.txt to y_test.txt
Y_test <- read.table(file.path(absolute_data_path, "test", "y_test.txt"), header = FALSE)
Subject_test <- read.table(file.path(absolute_data_path, "test", "subject_test.txt"), header = FALSE)


# 3. Merge Training and Test Sets (Step 1)
X_combined <- rbind(X_train, X_test)
Y_combined <- rbind(Y_train, Y_test)
Subject_combined <- rbind(Subject_train, Subject_test)

# 4. Label Columns and Combine All Data
colnames(X_combined) <- features$V2
colnames(Y_combined) <- "Activity_ID"
colnames(Subject_combined) <- "Subject"
data_combined <- cbind(Subject_combined, Y_combined, X_combined)

# 5. Extract Mean and Std Measurements (Step 2)
# Extracts only the measurements on the mean and standard deviation for each measurement.
required_features <- grep("Subject|Activity_ID|mean\\(\\)|std\\(\\)", colnames(data_combined), ignore.case = TRUE)
data_mean_std <- data_combined[, required_features]

# 6. Use Descriptive Activity Names (Step 3)
# Uses descriptive activity names to name the activities in the data set.
colnames(activity_labels) <- c("Activity_ID", "Activity_Name")
data_mean_std <- merge(data_mean_std, activity_labels, by = "Activity_ID", all.x = TRUE)

# 7. Create Tidy Data Frame with Descriptive Variable Names (Step 4 - Cleaning)
# Step 4: Appropriately labels the data set with descriptive variable names (further cleaning).
data_tidy_step4 <- data_mean_std %>%
  select(Subject, Activity_Name, everything(), -Activity_ID)

# Clean up variable names
names(data_tidy_step4) <- gsub("[\\(\\)-]", "", names(data_tidy_step4))
names(data_tidy_step4) <- gsub("mean", "Mean", names(data_tidy_step4))
names(data_tidy_step4) <- gsub("std", "Std", names(data_tidy_step4))
names(data_tidy_step4) <- gsub("^t", "Time", names(data_tidy_step4))
names(data_tidy_step4) <- gsub("^f", "Frequency", names(data_tidy_step4))
names(data_tidy_step4) <- gsub("BodyBody", "Body", names(data_tidy_step4))
names(data_tidy_step4) <- gsub("Acc", "Accelerometer", names(data_tidy_step4))
names(data_tidy_step4) <- gsub("Gyro", "Gyroscope", names(data_tidy_step4))

# 8. Create Second Tidy Data Set with Averages (Step 5)
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data_final_averages <- data_tidy_step4 %>%
  group_by(Subject, Activity_Name) %>%
  # FIX: Remove the problematic '.names' argument for better compatibility with older dplyr versions.
  # We will rename the columns manually afterwards.
  summarise(across(where(is.numeric), mean)) %>%
  ungroup()

# Manually rename the new average columns by adding the 'Average_' prefix (FIX for Step 5 naming)
# We start renaming from the 3rd column because the first two are 'Subject' and 'Activity_Name'
average_cols_start_index <- 3
avg_cols_names <- names(data_final_averages)[average_cols_start_index:length(data_final_averages)]
names(data_final_averages)[average_cols_start_index:length(data_final_averages)] <- paste0("Average_", avg_cols_names)

# 9. Write the Final Output
write.table(data_final_averages, "tidy_data_averages.txt", row.name = FALSE)
