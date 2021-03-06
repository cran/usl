% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/predict.R
\name{predict,USL-method}
\alias{predict,USL-method}
\title{Predict method for Universal Scalability Law models}
\usage{
\S4method{predict}{USL}(
  object,
  newdata,
  alpha,
  beta,
  interval = c("none", "confidence"),
  level = 0.95
)
}
\arguments{
\item{object}{A USL model object for which prediction is desired.}

\item{newdata}{An optional data frame in which to look for variables
with which to predict. If omitted, the fitted values are used.}

\item{alpha}{Optional parameter to be used for evaluation instead of the
parameter computed for the model.}

\item{beta}{Optional parameter to be used for evaluation instead of the
parameter computed for the model.}

\item{interval}{Type of interval calculation. Default is to calculate no
confidence interval.}

\item{level}{Confidence level. Default is 0.95.}
}
\value{
\code{predict} produces a vector of predictions or a matrix of
  predictions and bounds with column names \code{fit}, \code{lwr}, and
  \code{upr} if \code{interval} is set to "\code{confidence}".
}
\description{
\code{predict} is a function for predictions of the scalability of a system
modeled with the Universal Scalability Law. It evaluates the regression
function in the frame \code{newdata} (which defaults to
\code{model.frame(object)}). Setting \code{interval} to "\code{confidence}"
requests the computation of confidence intervals at the specified
\code{level}.
}
\details{
The parameters \code{alpha} or \code{beta} are useful to do a what-if
analysis. Setting these parameters override the model parameters and show
how the system would behave with a different contention or coherency delay
parameter.

\code{predict} internally uses the function returned by
\code{\link{scalability,USL-method}} to calculate the result.
}
\examples{
require(usl)

data(raytracer)

## Print predicted result from USL model for demo dataset
predict(usl(throughput ~ processors, raytracer))

## The same prediction with confidence intervals at the 99\% level
predict(usl(throughput ~ processors, raytracer),
        interval = "confidence", level = 0.99)

}
\references{
Neil J. Gunther. Guerrilla Capacity Planning: A Tactical
  Approach to Planning for Highly Scalable Applications and Services.
  Springer, Heidelberg, Germany, 1st edition, 2007.
}
\seealso{
\code{\link{usl}}, \code{\link{scalability,USL-method}},
  \code{\link{USL-class}}
}
