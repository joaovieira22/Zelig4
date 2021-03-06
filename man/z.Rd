\name{z}
\alias{z}
\title{Return value for a zelig2-function}
\usage{
  z(.function, ..., .hook = NULL)
}
\arguments{
  \item{.function}{a function}

  \item{...}{a set of parameters to be evaluated
  symbolically}

  \item{.hook}{a function to be applied after the external, model-fitting
  function is called}
}
\value{
  a ``z'' object which specifies how to evaluate the fitted
  model
}
\description{
  This is an API-function that bridges a model-fitting
  function with a zelig interface.
}
\note{
  This is used internally by Zelig-dependent packages to
  instruct Zelig how to evaluate the function call to a
  particular statistical model.
}

