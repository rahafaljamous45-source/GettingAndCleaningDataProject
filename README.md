Getting and Cleaning Data Course Project

This repository contains the R script, documentation, and the final tidy data set for the Getting and Cleaning Data Course Project, based on the UCI HAR Dataset.

Files in the Repository

run_analysis.R: The R script that performs all data cleaning and transformation steps (Steps 1-5).

CodeBook.md: A detailed document describing the original and final variables, the data source, and the specific transformations performed on the data.

README.md: This file, providing an essential overview of the project and instructions on how to run the analysis script.

How to Run the Analysis Script

The script run_analysis.R is designed to be run in an R environment (like RStudio) under the following assumptions:

Data Placement: The script assumes that the UCI HAR Dataset has been downloaded and successfully unzipped. The unzipped folder, named UCI HAR Dataset, must be placed in the main working directory where run_analysis.R is located.

Ensure Library: Make sure you have the necessary data manipulation package installed and loaded:

library(dplyr)


Execute: Run the script using the source() function in your R console:

source("run_analysis.R")


Output

The execution of the script generates one file in your working directory:

tidy_data_averages.txt: The final tidy data set containing the average of each mean() and std() variable for every unique combination of Activity and Subject.
