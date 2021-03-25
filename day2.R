# Introduction to R Workshop: Day 2
# Date: March 18, 2021
# Topics: Data Visualization & Analysis
# Instructor: Shirley Wang

##---- Packages ----
if (!require("psych")) {install.packages("psych"); require("psych")}
if (!require("psychTools")) {install.packages("psychTools"); require("psychTools")}
if (!require("corrplot")) {install.packages("corrplot"); require("corrplot")}
if (!require("ggplot2")) {install.packages("ggplot2"); require("ggplot2")}
if(!require("rcompanion")) {install.packages("rcompanion"); require("rcompanion")}
if(!require('car')) {install.packages("car"); require('car')}

##---- Data Visualization: Base R ----
# Let's work with the affect dataset today! 
# First, an excellent website with tons of info/cheatsheets on base R plotting: 
# https://www.r-graph-gallery.com/base-R.html

data(affect)
head(affect)
?affect
View(affect)

##---- 1. Scatterplots ----
# helpful page: https://www.statmethods.net/graphs/scatterplot.html
plot(affect$traitanx, affect$neur, main = "Scatterplot of Trait Anxiety and Neuroticism", 
     xlab = "Trait Anxiety", ylab = "Neuroticism")
abline(lm(affect$neur ~ affect$traitanx))

# change color and plotting character
plot(affect$traitanx, affect$neur, main = "Scatterplot of Trait Anxiety and Neuroticism", 
     xlab = "Trait Anxiety", ylab = "Neuroticism",
     pch = 23, col = 'lightblue')
abline(lm(affect$neur ~ affect$traitanx), col = 'darkblue')

?pch
colors() # list of colors

# scatterplot matrix
?pairs.panels
pairs.panels(affect[3:8],
             method = 'pearson', 
             density = TRUE,
             ellipses = FALSE,
             lm = TRUE)

##---- 2. Histograms ----
# helpful page: https://www.r-bloggers.com/2015/03/how-to-make-a-histogram-with-basic-r/

hist(affect$neur, main = 'Histogram of Neuroticism')
hist(affect$traitanx, main = 'Histogram of Neuroticism', breaks = 5) # we can change the number of breaks 

# we can also overlay histograms to look at distribution of multiple variables
hist(affect$neur, 
     col = 'lightblue', # set color
     main = 'Histogram of Neuroticism and Extraversion',
     xlab = 'Intensity',
     ylim = c(0, 70))
hist(affect$ext, 
     col = alpha('lightgreen', 0.4), 
     add = TRUE)
legend(x = 'topright', 
       legend = c("Neuroticism", "Extraversion"), 
       col = c("lightblue", "lightgreen"), lwd = 5)

##---- 3. Bar plots ----
# helpful page: https://www.statmethods.net/graphs/bar.html

# let's see how many people were assigned to watch each film
class(affect$Film) # it's integer right now - we need to convert to factor
affect$Film <- as.factor(affect$Film)
class(affect$Film) # yay! let's change factor levels now

levels(affect$Film)
levels(affect$Film) <- c('Documentary', 'Horror Film', 'Nature Film', 'Comedy')

counts <- table(affect$Film)
counts
barplot(counts, main = 'Film Bar Plot')
barplot(counts, main = 'Film Bar Plot', horiz = TRUE)

##---- 4. Box plots ----
# helpful page: https://www.statmethods.net/graphs/boxplot.html

boxplot(affect$NA2, main = 'Boxplot of Negative Affect')
boxplot(affect$NA2 ~ affect$Film, main = 'Negative Affect by Film')

# a general note about plots in base R: you can put multiple plots on the same window! 
# use op <- par(mfrow = c(rows, columns))
op <- par(mfrow = c(1, 2))
boxplot(affect$NA2, main = 'Boxplot of Negative Affect')
boxplot(affect$PA2, main = 'Boxplot of Positive Affect')
par(op) # return to previous settings (1 row, 1 column)

##---- 5. Correlation matrix ----
# helpful page: https://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html
# Note: using the corrplot package

# first create a correlation matrix 
names(affect)
cormat <- cor(affect[c(3:5, 10:17)], use = 'pairwise.complete.obs')
corrplot(cormat) # so much better than a correlation table! 
corrplot(cormat, method = 'number') # you can get numbers too
corrplot.mixed(cormat) # or both! 
corrplot(cormat, type = "lower", tl.col = "black", tl.srt = 45) # change some more features

##---- Data Visualization: ggplot! ----
# While base R plots are great for speedy data visualizations prior to/during data analysis,
# we sometimes want nicer visualizations for papers/presentations. ggplot is a fantastic 
# and very powerful package for data visualization using a *grammar of graphics*. It's part of
# the tidyverse (https://www.tidyverse.org/) but you don't have to use the tidyverse to use 
# ggplot. I primarily use ggplot to create publication-ready graphics, and stick to base R for
# almost everything else! 

# Just like language has grammer (to help us communicate with each other), ggplot relies on a
# 'grammar of graphics'. See more here: https://uc-r.github.io/ggplot_intro
# Find a ton of info on the ggplot page: https://ggplot2.tidyverse.org/
# ggplot cheat sheet: https://rstudio.com/wp-content/uploads/2015/08/ggplot2-cheatsheet.pdf

# Let's build out a ggplot in layers. 

# layer 1: name the data set
ggplot(data = affect) # just a blank screen

# layer 2: add aesthetic mappings (map variables --> visual aspects)
ggplot(data = affect, aes(x = traitanx, y = neur)) # variables mapped to axes! 

# layer 3: add geometric objects to appear on the plot 
ggplot(data = affect, aes(x = traitanx, y = neur)) +
  geom_point() # use the + operator to add new layers 

# more on layer 3...change color of dots! 
ggplot(data = affect, aes(x = traitanx, y = neur)) +
  geom_point(color = 'cadetblue4', alpha = 0.8) 

# layer 4: add a regression line! 
ggplot(data = affect, aes(x = traitanx, y = neur)) +
  geom_point(color = 'cadetblue4', alpha = 0.8) +
  geom_smooth(method = 'lm') # specifying linear regression

# more on layer 4: use a different regression method! 
?geom_smooth()

ggplot(data = affect, aes(x = traitanx, y = neur)) +
  geom_point(color = 'cadetblue4', alpha = 0.8) +
  geom_smooth(method = 'gam', color = 'darkgrey') # generalized additive model

# layer 5: add labels!
ggplot(data = affect, aes(x = traitanx, y = neur)) +
  geom_point(color = 'cadetblue4', alpha = 0.8) +
  geom_smooth(method = 'gam', color = 'darkgrey') +
  labs(title = 'Relationship between trait anxiety and neuroticism', 
       x = 'Trait Anxiety', 
       y = 'Neuroticism')

# layer 6: customize the theme 
ggplot(data = affect, aes(x = traitanx, y = neur)) +
  geom_point(color = 'cadetblue4', alpha = 0.8) +
  geom_smooth(method = 'gam', color = 'darkgrey') +
  labs(title = 'Relationship between trait anxiety and neuroticism', 
       x = 'Trait Anxiety', 
       y = 'Neuroticism') +
  theme_bw() + 
  theme(plot.title = element_text(size = 15, hjust = 0.5), 
        axis.title = element_text(size = 12), 
        axis.text = element_text(size = 10))

# Some more examples:

# distribution of tense arousal by film type
ggplot(data = affect, aes(x = Film, y = TA2, color = Film, fill = Film)) +
  geom_boxplot(alpha = 0.1) + 
  geom_dotplot(binaxis = 'y', stackdir = 'center', dotsize = 0.3) +
  labs(title = 'Time 2 Tense Arousal by Film Type', 
       x = 'Film Type', 
       y = 'Tense Arousal: Time 2') +
  theme_bw() + 
  theme(plot.title = element_text(size = 15, hjust = 0.5), 
        axis.title = element_text(size = 12), 
        axis.text = element_text(size = 10))

# tense arousal from T1 -> T2 by film type
ggplot(data = affect, aes(x = TA1, y = TA2, color = Film)) +
  geom_point() + 
  geom_smooth(method = 'lm') + 
  labs(title = 'Change in Tense Arousal by Film Type', 
       x = 'Tense Arousal: Time 1', 
       y = 'Tense Arousal: Time 2') +
  theme_bw() + 
  theme(plot.title = element_text(size = 15, hjust = 0.5), 
        axis.title = element_text(size = 12), 
        axis.text = element_text(size = 10))

# Facet wrap 
ggplot(data = affect, aes(x = TA1, y = TA2)) +
  geom_point(color = 'darkgrey') + 
  geom_smooth(method = 'lm', color = 'black') + 
  labs(title = 'Change in Tense Arousal by Film Type', 
       x = 'Tense Arousal: Time 1', 
       y = 'Tense Arousal: Time 2') +
  facet_wrap(~ Film) + 
  theme_bw() + 
  theme(plot.title = element_text(size = 15, hjust = 0.5), 
        axis.title = element_text(size = 12), 
        axis.text = element_text(size = 10))


##---- Data Analysis ----
# Let's start analyzing some data! We'll go through some basics of frequentist inferential
# statistics, but there is *so* much more out there. Almost any analysis I've ever wanted to do
# has been implented in R! 

# let's use a new data set! 
data(bfi)
?bfi
describe(bfi) # here's a nice function for getting quick descriptives of your data 

# creating personality sum scores using code from documentation file:
keys <-
  list(agree=c("-A1","A2","A3","A4","A5"),conscientious=c("C1","C2","C3","-C4","-C5"),
       extraversion=c("-E1","-E2","E3","E4","E5"),neuroticism=c("N1","N2","N3","N4","N5"),
       openness = c("O1","-O2","O3","O4","-O5")) 

scores <- psych::scoreItems(keys,bfi,min=1,max=6) #specify the minimum and maximum values
head(scores$scores)
bfi_scores <- cbind(bfi, scores$scores)
View(bfi_scores)

# One important note about notation:  
# we've seen the tilde operator '~' before and it comes up again here. This is used to define 
# relationships between dependent and independent variables in R. The DV appears on the left of
# the tilde and the IV(s) appear on the right hand side.

##---- 1. T-tests ----
# Is there a significant age difference in the men and women who participated in 
# this study? 

# let's first look at the data! 
boxplot(bfi_scores$age ~ bfi_scores$gender) ## looks pretty identical

# run the test using the t.test function
?t.test
t.test(bfi_scores$age ~ bfi_scores$gender)

# what about other variables? 
t.test(bfi_scores$agree ~ bfi_scores$gender)

##---- 2. Correlation ----
# we've already run correlations earlier (when building a correlation matrix), but let's dig in 
# with some more detail! let's explore the correlation between 

# first visualize the data 
plot(bfi_scores$agree, bfi_scores$extraversion)

# the basic function is cor()
?cor

cor(bfi_scores$agree, bfi_scores$extraversion, use = 'pairwise.complete.obs')
cor(bfi_scores[28:33], use = 'pairwise.complete.obs')
cor(bfi_scores[28:33], use = 'pairwise.complete.obs', method = 'spearman') # default is pearson

# to get a p-value, use cor.test()
?cor.test

cor.test(bfi_scores$agree, bfi_scores$extraversion, use = 'pairwise.complete.obs')

##---- 3. Regression ----
# here we use the tilde formula again
# for linear regression, the function is lm()
?lm

# what's the effect of agreeableness on extraversion? 
mod1 <- lm(extraversion ~ agree, data = bfi_scores) # fit regression model
summary(mod1) # return results

# effect of agreeableness, neuroticism, & openness on extraversion
mod2 <- lm(extraversion ~ agree + neuroticism + openness, data = bfi_scores)
summary(mod2)

# we should always make sure to check assumptions and model diagnostics
plot(mod1)

# residuals vs fitted: linear relationship? 
# qq plot: on the line?
# scale-location: homogeneity of variance?
# residuals vs leverage: high leverage points (outliers)?

# for logistic regression, we use glm()
# let's dichotomize agreeableness (just as a demonstration)
hist(bfi_scores$extraversion)
bfi_scores$extraversion_d <- as.factor(ifelse(bfi_scores$extraversion > 4, 1, 0))
plot(bfi_scores$extraversion_d)

?glm

mod3 <- glm(extraversion_d ~ agree + neuroticism + openness, family = binomial(link = 'logit'), data = bfi_scores)
summary(mod3) # model summary
exp(coef(mod3)) # e^coef gives odds ratios
nagelkerke(mod3) # r^2 and likelihood ratio test
vif(mod3) # variance inflation factor

# assumptions: https://rpubs.com/guptadeepak/logit-assumptions

##---- 4. ANOVA ----
# ANOVA is the same thing as regression 
# https://www.theanalysisfactor.com/why-anova-and-linear-regression-are-the-same-analysis/
# but sometimes it's still helpful to think in terms of ANOVA! so here's how to do it in R:

# is there a difference in openness between different education levels?
class(bfi_scores$education)
bfi_scores$education <- as.factor(bfi_scores$education)
class(bfi_scores$education)

mod4 <- aov(openness ~ education, data = bfi_scores) # fit anova
summary(mod4) # results 
TukeyHSD(mod4) # pairwise differences
