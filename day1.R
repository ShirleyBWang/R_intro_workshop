# Introduction to R Workshop: Day 1
# Date: March 18, 2021
# Topics: Data Cleaning & Wrangling
# Instructor: Shirley Wang

##----- Basics of R and RStudio ----

# R is a free programming language. RStudio is an integrated development environment (IDE) that makes it 
# easier to write, run, and save R code! 

# When you write R code, you're giving the computer specific instructions on what to do. E.g., compute numbers, 
# save information, run analyses, make data visualizations. Here's a very basic line of code:

4 + 7 * 10 

# You can run this line of code by putting your cursor anywhere on the line (doesn't have to be at the start)
# and hitting C+Enter. You can also highlight part of the line and run only a portion of the code
# Try highlighting just the '7 * 10' portion and running it. R will ignore the unhighlighted part! 

# Note that we're writing this code in the source editor, in this case a .R file, that we can save and come back
# to in the future. The output pops up in the console window below. We can also type directly into the console 
# window - try it now! 

# The '#' sign indicates a "comment". These are your own notes/descriptions; the '#' sign tells the computer
# to not run whatever follows it (on the same line) as code. It's good practice to comment your code and leave notes 
# for yourself so when you come back to it a few weeks/months/years later, you remember what you were doing :)

# OK, let's get familiar with the RStudio environment...
# We've got the source editor and the console windows on the lefthand side, which we're already familiar with now. 
# On the righthand side, we've got a top pane with the environment that displays any data or objects you have 
# (more on objects later). We don't have any data yet, so this is empty! 

# On the bottom panel, we have tabs for files (like Finder in mac), plots (for when you make data viz), 
# packages (more on this later), and help! 

##---- Operations ----

# R has built-in functionality for numerous operations, including arithmetic (addition, subtraction, etc), 
# and logical (less than, greater than, and, or, etc) operations. 

# some arithmetic operators
5 + 10
5 - 10
5 * 10
5 / 10
5 ^ 10

# some logical operators 
5 < 10 
5 > 10
5 = 10 
# ahh! this gives an error. why? 
# to test equality, you need two 2 equals signs. R thinks that 1 equal sign is for assignment of values
# to objects (more on this later). 

# In general, a huge part of learning R is reading and understanding error messages. Google is your 
# friend here! I've rarely met an error message in R that I couldn't find an answer to by googling it. 

5 == 10 # this works! 
5 != 10

##---- Objects ----

# All information in R is stored in objects. This allows us to access previously computed information at 
# any time by just typing the name of the object! 

# Objects are created using the assignment '<-' 
# (You can also use a single equals sign '=' but use of '<-' is encouraged)

# For example, 
x <- 4 + 7 * 10 
y <- x * 2
# creates an object 'x' that stores the result to this operation! 
# the second line creates another object 'y' using the first object 'x'

# some rules about objects: 
# 1. they must start with a letter (not a number or a symbol)
# 2. they can only contain letters, numbers, periods, and underscores (no other symbols or spaces)
# 3. they are case-sensitive (so an object X is unique from an object x)

################## PRACTICE! ##################
# Create an object called myName and assign your name as the value



##---- Data Types ----

# So far we've only been working with numbers and some booleans (true/false values). 
# R has many other data types! 

class(1.5) 
class(1)
class(as.integer(1))
class("EDCRP")
class(EDCRP) # why does this give an error?

EDCRP <- c('Jenny', 'Kamryn', 'Kendra', 'Missy')

# whoa, what's the c() here for? this is a function that means concatenate - so bind all the 
# elements within a c() together. 

?c

class(EDCRP) # now EDCRP exists and is an object of class character! 

##---- Data Structures ----

# We know data are stored in objects, but what types of structures are available? 
# There are a lot! The primary ones to be aware of are vectors and dataframes. 

# Vectors are the most basic type of data structure in R. We've already seen a vector above 
# with the EDCRP object. Vectors are created with c(). 

someNumbers <- c(3, 1, 4, 1, 5, 9)
class(someNumbers)
str(someNumbers)

# We can do math with vectors:
someNumbers * 5 # multiples every element in the vector by 5
someNumbers + someNumbers 

# Note that vectors can only contain one data type. E.g., 
anotherVector <- c(3, 1, 4, 1, 5, "shirley")
class(anotherVector) # because I included a string, all the elements have been coerced to character 

# Beyond vectors, the most important data type to be familiar with are data frames. 
# R comes with a few built-in data frames (i.e., data sets). Let's explore the iris data set: 
data(iris)
View(iris)
?iris

# Access columns using $
iris$Sepal.Length
mean(iris$Sepal.Length)

# We can also access elements of the data frame using brackets to index [nrow, ncol]
iris[5, 1] # what's this giving us?

# Explore other elements of the data frame
dim(iris) # how many rows and columns?
colnames(iris)
str(iris)
anyNA(iris) 
sum(is.na(iris))
head(iris) # a helpful function for looking at the first few rows of a data frame 

################## PRACTICE! ##################
# 1. calculate the ratio of sepal length:sepal width for each flower


# 2. store this ratio as a new variable (column) in the iris data frame


# 3. find the median of this ratio 


##---- Subsetting ----

# Sometimes, we want to subset the data to only include certain rows. Here's how we subset in R: 
?subset

# Let's try subsetting iris to only include species setosa: 
setosaOnly <- subset(iris, Species == 'setosa')

# Let's create a new data frame that only includes Petal Measurements
petalOnly <- subset(iris, select = c('Petal.Length', 'Petal.Width'))

################## PRACTICE! ##################
# 1. Subset the iris data frame to only include Sepal Measurements for species versicolor


# 2. Subset the iris data frame to only include Petal Measurements for flowers with Petal.Width > 0.5


##---- Functions ----

# Functions are sets of instructions/statements that take inputs, complete a specific
# task, and return output. We've already used several functions. Can you name some?

# You can also write your own functions to perform tasks! This can be helpful to repeat
# the same task multiple times (instead of typing it out every time). 

# Here's a simple function: 

sayHi <- function(name) {
  print(paste("Hi,", name))
}

# What's this function doing? 

# If we're not sure, you can try to work through the code piece-by-piece to get a 
# better understanding: 

name <- myName
name
paste("Hi,", name)
print(paste("Hi,", name))

# So now we see, this function takes as input a name, and prints "hi, name"! 
# Try it out for yourself: 
sayHi(myName)

# We can make this function more complicated with more arguments (inputs): 
saySomething <- function(name, greeting) {
  if (greeting == 'hi') {
    print(paste("Hi,", name))
  }
  if (greeting == 'bye') {
    print(paste("Bye,", name))
  }
}

# What's this function doing? 

saySomething(myName, 'hi')
saySomething(myName, 'bye')


################## PRACTICE! ##################
# Write a function to make (very simple) ED diagnoses of AN, BN, or BED! 
# Your function should take as input: 
# 1. BMI
# 2. Number binge episodes per week
# 3. Number purge episodes per week 

# Based on these inputs, your function should return or print the correct diagnosis 
# AN if BMI < 17.5
# BN if BMI > 17.5 and binge/purge episodes > 1
# BED if BMI > 17.5, binge episodes > 1, purge episodes < 1



##---- Packages ----
# R packages are bundles of functions, documentation, and data. There are over 17,000 packages! 
browseURL("Https://cran.r-project.org/")

# Base R comes with several packages already installed. Look at them with: 
library()

# However, there are MANY more packages out there that can help you do your research! Some 
# that we'll explore are the 'psych' package (lots of helpful functions for doing psych research in R)
# and 'ggplot2' (for data visualization). 

install.packages('psych') # install on your computer
library(psych) # load into this R session to work with 

?psych

# The psych package comes with several helpful datasets for us to work with. Let's focus on the msq! 

################## PRACTICE! ##################
# 1. Load the msq dataset 


# 2. Explore it! find the dimensions (n cols & n rows), column names, & amount of missingness.


# 3. Use the describe() function to examine descriptives of the msq data set. (hint: check ?describe)


# 4. Read the data documentation to create 2 vectors: 1 of the items for all the NA items, 1 for the PA items


# 5. ADVANCED: write a function that takes as input 'PA' or 'NA', and returns a vector of sum score positive or 
# negative affect for each participant. Add this vector as a column to the msq data frame. 



##---- Loops ----

# When we need to repeat the same task over and over again, loops can help automate this process (rather than 
# copy/pasting the same chunk of code over and over). There are several different types of loops, but today we'll
# cover the most common for-loop. 

for (i in 1:10){
  print(i)
}

# Let's see how much data each participant is missing. How do we go about this? 
# We need to count how many NAs are in each row (i.e., each participant). 

for (participant in 1:nrow(msq)) {
  print(sum(is.na(msq[participant, ])))
}

# Let's go one step further and actually save this information as a new variable! 
# To do so, we can first initialize an empty vector
nMissing <- vector()
nMissing

for (participant in 1:nrow(msq)) {
  nMissing[participant] <- sum(is.na(msq[participant, ]))
}

nMissing # now it's filled in! let's bind it to the data frame
msq$nMissing <- nMissing
View(msq)

################## PRACTICE! ##################
# 1. Subset the data frame to only inlcude NA and PA items 



# 2. Using a for loop, create a vector 'complete' that contains TRUE if the particpant has complete
# data; and FALSE if the participant has any missing data (hint: check out the ifelse() function!)



# 3. Add this vector to the msq data frame as a new variable.



# 4. Subset the dataframe to only include completers. How many participants do we lose? 

