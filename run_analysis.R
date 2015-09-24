# Import test data
body_acc_x_test <- read.table("./test/Inertial Signals/body_acc_x_test.txt")
body_acc_y_test <- read.table("./test/Inertial Signals/body_acc_y_test.txt")
body_acc_z_test <- read.table("./test/Inertial Signals/body_acc_z_test.txt")
body_gyro_x_test <- read.table("./test/Inertial Signals/body_gyro_x_test.txt")
body_gyro_y_test <- read.table("./test/Inertial Signals/body_gyro_y_test.txt")
body_gyro_z_test <- read.table("./test/Inertial Signals/body_gyro_z_test.txt")
total_acc_x_test <- read.table("./test/Inertial Signals/total_acc_x_test.txt")
total_acc_y_test <- read.table("./test/Inertial Signals/total_acc_y_test.txt")
total_acc_z_test <- read.table("./test/Inertial Signals/total_acc_z_test.txt")
subject_test <- read.table("./test/subject_test.txt")
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")

# Import train data
body_acc_x_train <- read.table("./train/Inertial Signals/body_acc_x_train.txt")
body_acc_y_train <- read.table("./train/Inertial Signals/body_acc_y_train.txt")
body_acc_z_train <- read.table("./train/Inertial Signals/body_acc_z_train.txt")
body_gyro_x_train <- read.table("./train/Inertial Signals/body_gyro_x_train.txt")
body_gyro_y_train <- read.table("./train/Inertial Signals/body_gyro_y_train.txt")
body_gyro_z_train <- read.table("./train/Inertial Signals/body_gyro_z_train.txt")
total_acc_x_train <- read.table("./train/Inertial Signals/total_acc_x_train.txt")
total_acc_y_train <- read.table("./train/Inertial Signals/total_acc_y_train.txt")
total_acc_z_train <- read.table("./train/Inertial Signals/total_acc_z_train.txt")
subject_train <- read.table("./train/subject_train.txt")
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")

# Merge data
body_acc_x_merged <- rbind(body_acc_x_train,body_acc_x_test)
body_acc_y_merged <- rbind(body_acc_y_train,body_acc_y_test)
body_acc_z_merged <- rbind(body_acc_z_train,body_acc_z_test)
body_gyro_x_merged <- rbind(body_gyro_x_train,body_gyro_x_test)
body_gyro_y_merged <- rbind(body_gyro_y_train,body_gyro_y_test)
body_gyro_z_merged <- rbind(body_gyro_z_train,body_gyro_z_test)
total_acc_x_merged <- rbind(total_acc_x_train,total_acc_x_test)
total_acc_y_merged <- rbind(total_acc_y_train,total_acc_y_test)
total_acc_z_merged <- rbind(total_acc_z_train,total_acc_z_test)
subject_merged <- rbind(subject_train,subject_test)
X_merged <- rbind(X_train,X_test)
y_merged <- rbind(y_train,y_test)

# Calculate mean for each measurement
body_acc_x_mean <- rowMeans(body_acc_x_merged)
body_acc_y_mean <- rowMeans(body_acc_y_merged)
body_acc_z_mean <- rowMeans(body_acc_z_merged)
body_gyro_x_mean <- rowMeans(body_gyro_x_merged)
body_gyro_y_mean <- rowMeans(body_gyro_y_merged)
body_gyro_z_mean <- rowMeans(body_gyro_z_merged)
total_acc_x_mean <- rowMeans(total_acc_x_merged)
total_acc_y_mean <- rowMeans(total_acc_y_merged)
total_acc_z_mean <- rowMeans(total_acc_z_merged)
X_mean <- rowMeans(X_merged)

# Calculate standard deviation for each measurement
body_acc_x_sd <- apply(body_acc_x_merged,1,sd)
body_acc_y_sd <- apply(body_acc_y_merged,1,sd)
body_acc_z_sd <- apply(body_acc_z_merged,1,sd)
body_gyro_x_sd <- apply(body_gyro_x_merged,1,sd)
body_gyro_y_sd <- apply(body_gyro_y_merged,1,sd)
body_gyro_z_sd <- apply(body_gyro_z_merged,1,sd)
total_acc_x_sd <- apply(total_acc_x_merged,1,sd)
total_acc_y_sd <- apply(total_acc_y_merged,1,sd)
total_acc_z_sd <- apply(total_acc_z_merged,1,sd)
X_sd <- apply(X_merged,1,sd)

# Combine all variables in 1 dataset and rename columns
data <- data.frame(subject_merged,y_merged,
              body_acc_x_mean,body_acc_y_mean,body_acc_z_mean,
              body_gyro_x_mean,body_gyro_y_mean,body_gyro_z_mean,
              total_acc_x_mean,total_acc_y_mean,total_acc_z_mean,X_mean,
              body_acc_x_sd,body_acc_y_sd,body_acc_z_sd,
              body_gyro_x_sd,body_gyro_y_sd,body_gyro_z_sd,
              total_acc_x_sd,total_acc_y_sd,total_acc_z_sd,X_sd)
colnames(data) <- c("Subject","Activity",
                    "Mean body accel in x dir","Mean body accel in y dir","Mean body accel in z dir",
                    "Mean body gyro in x dir","Mean body gyro in y dir","Mean body gyro in z dir",
                    "Mean total accel in x dir","Mean total accel in y dir","Mean total accel in z dir","Mean X",
                    "Std dev body accel in x dir","Std dev body accel in y dir","Std dev body accel in z dir",
                    "Std dev body gyro in x dir","Std dev body gyro in y dir","Std dev body gyro in z dir",
                    "Std dev total accel in x dir","Std dev total accel in y dir","Std dev total accel in z dir","Std dev X")

# Create and save second dataset with average of each variable for each activity and each subject
data2 <- data.frame(matrix(ncol = 12, nrow = 180))
colnames(data2) <- c("Subject","Activity",
                    "Mean body accel in x dir","Mean body accel in y dir","Mean body accel in z dir",
                    "Mean body gyro in x dir","Mean body gyro in y dir","Mean body gyro in z dir",
                    "Mean total accel in x dir","Mean total accel in y dir","Mean total accel in z dir","Mean X")
k <- 1
for (i in 1:30) {
  for (j in 1:6) {
    data2[k,] <- colMeans(data[data$Subject==i & data$Activity==j,1:12])
    k <- k + 1
  }
}
write.table(data2,file="data2.txt",row.name=FALSE)

