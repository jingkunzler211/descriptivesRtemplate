# This is just a demonstration of what you can do using R, and to get you used to the syntax.
# In most cases, you'll just modify parameters in these scripts, but sometimes you'll need to change 
#   the statements themselves to get it to work with your own datasets.

# First, clear all previous stuff out of the workspace...
rm(list = ls())

# The capabilities of R are extended through user-created packages, which allow specialized statistical techniques, 
#   graphical devices, import/export capabilities, reporting tools (knitr, Sweave), etc.
# Psych is a package we will use to generate summary statistics

# Install required packages as needed
if (!require("psych")) { install.packages("psych")
  require("psych") }


# turn off scientific notation
options(scipen = 999)


# Import your dataset
dataSet <- read.csv("vgsales.csv")

# Read the CSV data file. Make sure:
#     1) The first row contain the data labels
#     2) Numeric data fields only contain numbers
#     3) The order of the data match the order of the labels


# Turn on output to a file (in addition to the screen). This way we've got a record of what we did.
#   append=FALSE means overwrite the file if it already exists
#   split=TRUE   means send the output to the console too!
sink("descriptivesOutput.txt", append=FALSE, split=TRUE)
# "descriptivesOutput.txt" is the name of the file that contains the text output (txt format). 

# Write out some text so that the output file makes sense...
#   cat() sends text to the output stream (console and the file)
#   \n means go to the next line. So \n\n means skip a line before whatever comes next.
cat("\n###### Let's get started with some fun statistics in RStudio! ######\n")

# Provide summary statisics of the Global_Sales variable in dataSet (mean, median, etc.).
#    dataSet is my clever name for the dataset. You can name it whatever you like.
#    So, the thing before the $ is the name of your dataset.
#    The thing after the $ is the name of the variable you want to examine (watch CAPS!).
#
# IF YOU WERE USING YOUR OWN DATASET HERE (OR WANTED TO ANALYZE A DIFFERENT VARIABLE)
# YOU'D NEED TO CHANGE THE VARIABLE NAME. SAME GOES FOR THE REST OF THIS SCRIPT!
cat("\n###### Summary statistics for dataset: ", "vgsales.csv", "using the summary() function: ######\n")
summary(dataSet$Global_Sales)

# You may want to find out more
# describe() is another useful function provided by the psych
cat("\n###### Summary statistics using the describe() function: ######\n")
describe(dataSet$Global_Sales)

# Provide summary statistics, this time grouped by Platform.
#    So the first parameter is the variable your summarizing, 
#    and the second parameter is the grouping variable. The grouping variable should be categorical
#    or you may get a crazy mess!
cat("\n###### Summary statistics split by variable 'Platform' using the describeBy() function: ######\n")
describeBy(dataSet$Global_Sales,dataSet$Platform)

cat("\n###### Which platform is better for video games, PSP or PC? ######\n")

# To compare the global sales of video games on PSP to PC, we'll do a t-test.
#    So we need to first create a new dataset with only those two groups.
#    The line below does that - give me the rows where Platform is PSP **OR** PC.
#       Use | for OR, and use & for AND.
# 
# AGAIN, BE CAREFUL HERE. FOR YOUR OWN DATA, YOU'D CHANGE THE VARIABLE NAME AND THE
#    CATEGORIES TO REFLECT WHAT'S IN YOUR OWN DATA SET. IF THERE WERE ONLY TWO LEVELS 
#    IN YOUR DATA TO START WITH, YOU COULD JUST DO THIS:
#    subset <- dataSet;
cat("\n###### Create a subset with only two platforms: PSP and PC... ######\n")
subset <- dataSet[ which(dataSet$Platform=='Wii' |  dataSet$Platform=='PC'), ]

# Now run a standard t-test. Use Global_Sales as your dependent variable
#     and Platform as your independent (grouping) variable.
# FOR YOUR OWN DATASET, ADJUST YOUR VARIABLES ACCORDINGLY!
cat("\n###### Performing a t-test: ######\n")
t.test(subset$Global_Sales~subset$Platform)

# This stops R from writing any more to the text output file.
sink()

# We can verify the data is (or is not) normally distributed through a histogram.
#    use hist() to do this.
#    the first parameter  is the variable of interest
#    the second parameter is the number of bars to generate (more bars = more detail)
#                         (R takes this parameter as a suggestion but ultimately does what it wants!!)
#    the third parameter  is the color of the shading of the bars
#    the fourth parameter is the label for the x-axis of the histogram
#    the fifth parameter is the title of the histogram
# FOR YOUR OWN DATASET, ADJUST YOUR VARIABLES ACCORDINGLY!!
hist(dataSet$Global_Sales, breaks=4, col="lightgrey", xlab="Global_Sales", main="Histogram of Video Game Sales")

# And now we run it again, but this time we send the output to a nice PDF file so you can look at it
# later, stick it up on your refrigerator, etc.
# FOR YOUR OWN DATASET, ADJUST YOUR VARIABLES ACCORDINGLY!!
pdf("histogram.pdf")
hist(dataSet$Global_Sales, breaks=4, col="lightpink", xlab="Global_Sales", main="Histogram of Video Game Sales")
dev.off()







