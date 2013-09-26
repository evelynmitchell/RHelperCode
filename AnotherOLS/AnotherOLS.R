# Get a set of "error" terms
set.seed(1234)
N = 100
E = rnorm(N, mean = 0, sd = 2)

lnLike = function(x, mu, sigma)
{
  n = length(x)
  lnLike = -n / 2 * log(2*pi)
  lnLike = lnLike - n/2 * log(sigma ^2)
  lnLike = lnLike - 1/(2*sigma^2)*sum((x - mu)^2)
  lnLike
}

# for a fixed sd, plot the likelihood function for various mu's
testMu = -50:50 / 100
likelihood = numeric(length(testMu))
for (i in 1:length(likelihood)){
  likelihood[i] = lnLike(e, testMu[i], 1)
}

plot(likelihood ~ testMu, pch = 19)
abline(v = 0)
abline(v = testMu[likelihood == max(likelihood)])

testMu[likelihood == max(likelihood)]

# for a fixed mu, plot the likelihood function for various sigma's
testSigma = 50:150 / 100
likelihood = numeric(length(testSigma))

for (i in 1:length(testSigma)){
  likelihood[i] = lnLike(e, 0, testSigma[i])
}

plot(likelihood ~ testSigma, pch = 19)
abline(v = 1)
abline(v = testSigma[likelihood == max(likelihood)])

testSigma[likelihood == max(likelihood)]

# Now plot the 2-dimensional case
params = expand.grid(mu = testMu, sigma = testSigma)

params$Likelihood = mapply(lnLike, params$mu, params$sigma, MoreArgs = list(x = e))
z = matrix(params$Likelihood, length(testMu), length(testSigma))

filled.contour(x=testMu, y=testSigma, z=z, color.palette = heat.colors, xlab = "mu", ylab = "sigma")

# Now we'll optimize the likelihood
lnLike2 = function(x, par)
{
  mu = par[1]
  sigma = par[2]
  
  lnLike(x, mu, sigma)
}

optim(par = c(-1,4), fn = lnLike2, control = list(fnscale = -1), x = e)
# Note that the sigma doesn't correspond to the maximum in our univariate illustration earlier
# because that assumed that mu = 0

optimize(interval = c(0.00001,5), f = lnLike, maximum = TRUE, x = e, mu = 0)
# Now things are consistent.

B0 = 5
Y = B0 + e

optim(par = c(-1,4), fn = lnLike2, control = list(fnscale = -1), x = Y)

fit = lm(Y ~ 1)
fit$coefficients[[1]]

X = as.double(1:length(E))
B1 = 1.5
Y = B0 + B1 * X + E

lnLike3 = function(par, Y, X)
{
  B0 = par[1]
  B1 = par[2]
  sigma = par[3]
  
  x = Y - B0 - B1 * X
  mu = 0
  
  lnLike(x, mu, sigma) 
}

optim(par = c(3, 2, 4), fn = lnLike3, control = list(fnscale = -1), Y = Y, X = X)

fit = lm(Y ~ 1 + X)
fit$coefficients

