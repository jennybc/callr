% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/eval.R
\name{r}
\alias{r}
\title{Evaluate an expression in another R session}
\usage{
r(func, args = list(), libpath = .libPaths(), repos = getOption("repos"),
  stdout = NULL, stderr = NULL, error = c("error", "stack", "debugger"),
  cmdargs = "--slave", show = FALSE, callback = NULL,
  system_profile = TRUE, user_profile = TRUE, env = character())
}
\arguments{
\item{func}{Function object to call in the new R process.
The function should be self-contained and only refer to
other functions and use variables explicitly from other packages
using the \code{::} notation. The environment of the function
is set to \code{.GlobalEnv} before passing it to the child process.
Because of this, it is good practice to create an anonymous
function and pass that to \code{callr}, instead of passing
a function object from a (base or other) package. In particular
\preformatted{  r(.libPaths)} does not work, because it is
defined in a special environment, but
\preformatted{  r(function() .libPaths())} works just fine.}

\item{args}{Arguments to pass to the function. Must be a list.
vector.}

\item{libpath}{The library path.}

\item{repos}{The \sQuote{repos} option. If \code{NULL}, then no
\code{repos} option is set. This options is only used if
\code{user_profile} or \code{system_profile} is set to \code{FALSE},
as it is set using the system or the user profile.}

\item{stdout}{The name of the file the standard output of
the child R process will be written to.
If the child process runs with the \code{--slave} option (the default),
then the commands are not echoed and will not be shown
in the standard output. Also note that you need to call `print()`
explicitly to show the output of the command(s).}

\item{stderr}{The name of the file the standard error of
the child R process will be written to.
In particular \code{message()} sends output to the standard
error. If nothing was sent to the standard error, then this file
will be empty.}

\item{error}{What to do if the remote process throws an error.
See details below.}

\item{cmdargs}{Command line arguments to pass to the R process.
Note that \code{c("-f", rscript)} is appended to this, \code{rscript}
is the name of the script file to run. This contains a call to the
supplied function and some error handling code.}

\item{show}{Logical, whether to show the standard output on the screen
while the child process is running. Note that this is independent
of the \code{stdout} and \code{stderr} arguments. The standard
error is not shown currently.}

\item{callback}{A function to call for each line of the standard
output from the child process. It works together with the \code{show}
option; i.e. if \code{show = TRUE}, and a callback is provided, then
the output is shown of the screen, and the callback is also called.}

\item{system_profile}{Whether to use the system profile file.}

\item{user_profile}{Whether to use the user's profile file.}

\item{env}{Environment variables to set for the child process.}
}
\value{
Value of the evaluated expression.
}
\description{
Evaluate an expression in another R session
}
\section{Error handling}{


\code{callr} handles errors properly. If the child process throws an
error, then \code{callr} throws an error with the same error message
in the parent process.

The \sQuote{error} expert option may be used to specify a different
behavior on error. The following values are possible: \itemize{
\item \sQuote{error} is the default behavior: throw an error
  in the parent, with the same error message. In fact the same
  error object is thrown again.
\item \sQuote{stack} also throws an error in the parent, but the error
  is of a special kind, class \code{callr_condition}, and it contains
  both the original error object, and the call stack of the child,
  as written out by \code{\link[utils]{dump.frames}}.
\item \sQuote{debugger} is similar to \sQuote{stack}, but in addition
  to returning the complete call stack, it also start up a debugger
  in the child call stack, via \code{\link[utils]{debugger}}.
}
}
\examples{

# Workspace is empty
r(function() ls())

# library path is the same by default
r(function() .libPaths())
.libPaths()

}
\seealso{
Other callr functions: \code{\link{r_safe}},
  \code{\link{r_vanilla}}
}

