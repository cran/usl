% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/summary.R
\name{summary,USL-method}
\alias{summary,USL-method}
\title{USL Object Summary}
\usage{
\S4method{summary}{USL}(object, ...)
}
\arguments{
\item{object}{A USL object.}

\item{...}{Other arguments passed to other methods.}
}
\description{
\code{summary} method for class "\code{USL}".
}
\examples{
require(usl)

data(raytracer)

## Show summary for demo dataset
summary(usl(throughput ~ processors, raytracer))

## Extract model coefficients
summary(usl(throughput ~ processors, raytracer))$coefficients

}
\seealso{
\code{\link{usl}}, \code{\link{USL-class}}
}
