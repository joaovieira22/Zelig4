#' Generic Method for Replicating Data
#' @param object a 'zelig' object
#' @param ... parameters
#' @return a replicated object
#' @export
#' @author Kosuke Imai and Olivia Lau \email{mowen@@iq.harvard.edu}
repl <- function(object, ...)
  UseMethod("repl")
#' Default Method for Replicating Statistics
#'
#' Replicate a simulation
#' @usage \method{repl}{default}(object, data=NULL, ...)
#' @S3method repl default
#' @param object an object to replicate
#' @param data a data.frame
#' @param ... ignored parameters
#' @return a replicated object
#' @author Kosuke Imai and Olivia Lau \email{mowen@@iq.harvard.edu}
repl.default <- function(object, data=NULL, ...) {
  if (!is.null(data))
    obectj$call$data <- data

  eval(object$call$data, sys.parent())
}
#' Method for Replicating Simulated Quantities of Interest
#'
#' Replicate simulated quantities of interest
#' @usage \method{repl}{sim}(object, x=NULL, x1=NULL, y=NULL,
#'                     num=1000,
#'                     prev = NULL, bootstrap = FALSE,
#'                     boot.fn=NULL,
#'                     cond.data = NULL, ...)
#' @S3method repl sim
#' @param object a 'zelig' object
#' @param x a 'setx' object
#' @param x1 a secondary 'setx' object used to perform particular computations
#'   of quantities of interest
#' @param y a parameter reserved for the computation of particular quantities of
#'   interest (average treatment effects). Few models currently support this
#'   parameter
#' @param num an integer specifying the number of simulations to compute
#' @param prev ignored
#' @param bootstrap ignored
#' @param boot.fn ignored
#' @param cond.data ignored
#' @param ... special parameters which are reserved for future versions of Zelig
#' @return a 'sim' object storing the replicated quantities of interest
#' @author Matt Owen \email{mowen@@iq.harvard.edu}
repl.sim <- function(object, x=NULL, x1=NULL, y=NULL,
                     num=1000,
                     prev = NULL, bootstrap = FALSE,
                     boot.fn=NULL,
                     cond.data = NULL, ...) {
  # would rather use a factory function
  new.call <- object$call


  # this should always give the same value...
  rep.zelig <- eval(object$zcall, sys.parent())

  # 
  new.call$z <- rep.zelig

  # x
  new.call$x <- if (is.null(x))
    object$x
  else
    x

  # x1
  new.call$x1 <- if (is.null(x1))
    object$x1
  else
    x1

  # how is this EVER true?
  if (!is.null(object$seed))
    set.seed(object$seed)

  eval(new.call, sys.parent())
}
