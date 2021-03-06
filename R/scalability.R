# Copyright (c) 2013-2020 Stefan Moeding
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.


##############################################################################
#' Scalability function of a USL model
#'
#' \code{scalability} is a higher order function and returns a function to
#' calculate the scalability for the specific USL model.
#'
#' The returned function can be used to calculate specific values once the
#' model for a system has been created.
#'
#' The parameters \code{alpha} and \code{beta} are useful to do a what-if
#' analysis. Setting these parameters override the model parameters and show
#' how the system would behave with a different contention or coherency delay
#' parameter.
#'
#' @param object A USL object.
#' @param alpha Optional parameter to be used for evaluation instead of the
#'   parameter computed for the model.
#' @param beta Optional parameter to be used for evaluation instead of the
#'   parameter computed for the model.
#' @param gamma Optional parameter to be used for evaluation instead of the
#'   parameter computed for the model.
#'
#' @return A function with parameter \code{x} that calculates the
#'   scalability value of the specific model.
#'
#' @seealso \code{\link{usl}},
#'   \code{\link{peak.scalability,USL-method}}
#'   \code{\link{optimal.scalability,USL-method}}
#'   \code{\link{limit.scalability,USL-method}}
#'
#' @references Neil J. Gunther. Guerrilla Capacity Planning: A Tactical
#'   Approach to Planning for Highly Scalable Applications and Services.
#'   Springer, Heidelberg, Germany, 1st edition, 2007.
#'
#' @examples
#' require(usl)
#'
#' data(raytracer)
#'
#' ## Compute the scalability function
#' scf <- scalability(usl(throughput ~ processors, raytracer))
#'
#' ## Print scalability for 32 CPUs for the demo dataset
#' print(scf(32))
#'
#' ## Plot scalability for the range from 1 to 64 CPUs
#' plot(scf, from=1, to=64)
#'
#' @aliases scalability
#' @export
#'
setMethod(
  f = "scalability",
  signature = "USL",
  definition = function(object, alpha, beta, gamma) {
    if (missing(alpha)) alpha <- coef(object)[['alpha']]
    if (missing(beta))  beta  <- coef(object)[['beta']]
    if (missing(gamma)) gamma <- coef(object)[['gamma']]

    .func <- function(x) {
      # Formula (4.31) on page 57 of GCaP:
      cap <- x / (1 + (alpha * (x-1)) + (beta * x * (x-1)))

      # Scale it to the measurements
      return(gamma * cap)
    }

    # Return the usl function (lexically scoped)
    return(.func)
  }
)


##############################################################################
#' Point of optimal scalability of a USL model
#'
#' Calculate the point of optimal scalability for a specific model.
#'
#' The point of optimal scalability is defined as:
#' 
#' \deqn{Nopt = \frac{1}{\alpha}}{Nopt = 1 / \alpha}
#' 
#' Below this point the existing capacity is underutilized. Beyond that point
#' the effects of diminishing returns become visible more and more.
#'
#' The value can be constructed graphically by projecting the intersection of
#' the linear scalability bound and the Amdahl asymptote onto the x-axis.
#'
#' The parameters \code{alpha}, \code{beta} and \code{gamma} are useful to do a
#' what-if analysis. Setting these parameters override the model parameters and
#' show how the system would behave with a different contention or coherency
#' delay parameter.
#'
#' The point of optimal scalability is undefined if \code{alpha} is zero.
#'
#' This function accepts a arguments for \code{beta} and \code{gamma} although
#' the values are not required to perform the calculation. This is on purpose
#' to provide a coherent interface.
#'
#' @param object A USL object.
#' @param alpha Optional parameter to be used for evaluation instead of the
#'   parameter computed for the model.
#' @param beta Optional parameter to be used for evaluation instead of the
#'   parameter computed for the model.
#' @param gamma Optional parameter to be used for evaluation instead of the
#'   parameter computed for the model.
#'
#' @return A numeric value for the load where optimal scalability will be
#'   reached.
#'
#' @seealso \code{\link{usl}},
#'   \code{\link{peak.scalability,USL-method}}
#'   \code{\link{limit.scalability,USL-method}}
#'
#' @examples
#' require(usl)
#'
#' data(specsdm91)
#'
#' optimal.scalability(usl(throughput ~ load, specsdm91))
#' ## Optimal scalability will be reached at about 36 virtual users
#'
#' @aliases optimal.scalability
#' @export
#'
setMethod(
  f = "optimal.scalability",
  signature = "USL",
  definition = function(object, alpha, beta, gamma) {
    if (missing(alpha)) alpha <- coef(object)[['alpha']]
    if (missing(beta))  beta  <- coef(object)[['beta']]
    if (missing(gamma)) gamma <- coef(object)[['gamma']]
    
    return(1 / alpha)
  }
)


##############################################################################
#' Scalability limit of a USL model
#'
#' Calculate the scalability limit for a specific model.
#'
#' The scalability limit is defined as:
#'
#'\deqn{Xroof = \frac{\gamma}{\alpha}}{Xroof = \gamma / \alpha}
#'
#' This is the upper bound (Amdahl asymptote) of system capacity.
#'
#' The parameters \code{alpha}, \code{beta} and \code{gamma} are useful to do a
#' what-if analysis. Setting these parameters override the model parameters and
#' show how the system would behave with a different contention or coherency
#' delay parameter.
#'
#' The scalability limit is undefined if \code{alpha} is zero.
#'
#' This function accepts an argument for \code{beta} although the value is not
#' required to perform the calculation. This is on purpose to provide a
#' coherent interface.
#'
#' @param object A USL object.
#' @param alpha Optional parameter to be used for evaluation instead of the
#'   parameter computed for the model.
#' @param beta Optional parameter to be used for evaluation instead of the
#'   parameter computed for the model.
#' @param gamma Optional parameter to be used for evaluation instead of the
#'   parameter computed for the model.
#'
#' @return A numeric value for the system capacity limit (e.g. throughput).
#'
#' @seealso \code{\link{usl}},
#'   \code{\link{peak.scalability,USL-method}}
#'   \code{\link{optimal.scalability,USL-method}}
#'
#' @examples
#' require(usl)
#'
#' data(specsdm91)
#'
#' limit.scalability(usl(throughput ~ load, specsdm91))
#' ## The throughput limit is about 3245
#'
#' @aliases limit.scalability
#' @export
#'
setMethod(
  f = "limit.scalability",
  signature = "USL",
  definition = function(object, alpha, beta, gamma) {
    if (missing(alpha)) alpha <- coef(object)[['alpha']]
    if (missing(beta))  beta  <- coef(object)[['beta']]
    if (missing(gamma)) gamma <- coef(object)[['gamma']]
    
    return(gamma / alpha)
  }
)


##############################################################################
#' Point of peak scalability of a USL model
#'
#' Calculate the point of peak scalability for a specific model.
#'
#' The peak scalability is the point where the throughput of the system starts
#' to go retrograde, i.e., starts to decrease with increasing load.
#'
#' The parameters \code{alpha}, \code{beta} and \code{gamma} are useful to do a
#' what-if analysis. Setting these parameters override the model parameters and
#' show how the system would behave with a different contention or coherency
#' delay parameter.
#'
#' See formula (4.33) in \emph{Guerilla Capacity Planning}.
#'
#' This function accepts an argument for \code{gamma} although the value is
#' not required to perform the calculation. This is on purpose to provide a
#' coherent interface.
#'
#' @param object A USL object.
#' @param alpha Optional parameter to be used for evaluation instead of the
#'   parameter computed for the model.
#' @param beta Optional parameter to be used for evaluation instead of the
#'   parameter computed for the model.
#' @param gamma Optional parameter to be used for evaluation instead of the
#'   parameter computed for the model.
#'
#' @return A numeric value for the point where peak scalability will be
#'   reached.
#'
#' @seealso \code{\link{usl}},
#'   \code{\link{optimal.scalability,USL-method}}
#'   \code{\link{limit.scalability,USL-method}}
#'
#' @references Neil J. Gunther. Guerrilla Capacity Planning: A Tactical
#'   Approach to Planning for Highly Scalable Applications and Services.
#'   Springer, Heidelberg, Germany, 1st edition, 2007.
#'
#' @examples
#' require(usl)
#'
#' data(specsdm91)
#'
#' peak.scalability(usl(throughput ~ load, specsdm91))
#' ## Peak scalability will be reached at about 96 virtual users
#'
#' @aliases peak.scalability
#' @export
#'
setMethod(
  f = "peak.scalability",
  signature = "USL",
  definition = function(object, alpha, beta, gamma) {
    if (missing(alpha)) alpha <- coef(object)[['alpha']]
    if (missing(beta))  beta  <- coef(object)[['beta']]
    if (missing(gamma)) gamma <- coef(object)[['gamma']]
    
    return(sqrt((1 - alpha) / beta))
  }
)
