http://www.r-tutor.com/elementary-statistics/analysis-variance/completely-randomized-design
dfl <- read.table("fastfood-1.txt", header=TRUE);
dfl
r = c(t(as.matrix(dfl)))
r
f = c("Item1", "Item2", "Item3")   # treatment levels 
k = 3                    # number of treatment levels 
n = 6                    # observations per treatment
tm = gl(k, 1, n*k, factor(f))   # matching treatments 
tm 
av = aov(r ~ tm)
av
summary(av)