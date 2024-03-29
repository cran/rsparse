% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model_GloVe.R
\name{GloVe}
\alias{GloVe}
\title{Global Vectors}
\description{
Creates Global Vectors matrix factorization model
}
\examples{
data('movielens100k')
co_occurence = crossprod(movielens100k)
glove_model = GloVe$new(rank = 4, x_max = 10, learning_rate = .25)
embeddings = glove_model$fit_transform(co_occurence, n_iter = 2, n_threads = 1)
embeddings = embeddings + t(glove_model$components) # embeddings + context embedings
identical(dim(embeddings), c(ncol(movielens100k), 10L))
}
\references{
\url{http://nlp.stanford.edu/projects/glove/}
}
\section{Public fields}{
\if{html}{\out{<div class="r6-fields">}}
\describe{
\item{\code{components}}{represents context embeddings}

\item{\code{bias_i}}{bias term i as per paper}

\item{\code{bias_j}}{bias term j as per paper}

\item{\code{shuffle}}{\code{logical = FALSE} by default. Whether to perform shuffling before
each SGD iteration. Generally shuffling is a good practice for SGD.}
}
\if{html}{\out{</div>}}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-GloVe-new}{\code{GloVe$new()}}
\item \href{#method-GloVe-fit_transform}{\code{GloVe$fit_transform()}}
\item \href{#method-GloVe-get_history}{\code{GloVe$get_history()}}
\item \href{#method-GloVe-clone}{\code{GloVe$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-GloVe-new"></a>}}
\if{latex}{\out{\hypertarget{method-GloVe-new}{}}}
\subsection{Method \code{new()}}{
Creates GloVe model object
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{GloVe$new(
  rank,
  x_max,
  learning_rate = 0.15,
  alpha = 0.75,
  lambda = 0,
  shuffle = FALSE,
  init = list(w_i = NULL, b_i = NULL, w_j = NULL, b_j = NULL)
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{rank}}{desired dimension for the latent vectors}

\item{\code{x_max}}{\code{integer} maximum number of co-occurrences to use in the weighting function}

\item{\code{learning_rate}}{\code{numeric} learning rate for SGD. I do not recommend that you
modify this parameter, since AdaGrad will quickly adjust it to optimal}

\item{\code{alpha}}{\code{numeric = 0.75} the alpha in weighting function formula :
\eqn{f(x) = 1 if x > x_max; else (x/x_max)^alpha}}

\item{\code{lambda}}{\code{numeric = 0.0} regularization parameter}

\item{\code{shuffle}}{see \code{shuffle} field}

\item{\code{init}}{\code{list(w_i = NULL, b_i = NULL, w_j = NULL, b_j = NULL)}
initialization for embeddings (w_i, w_j) and biases (b_i, b_j).
\code{w_i, w_j} - numeric matrices, should have #rows = rank, #columns =
expected number of rows (w_i) / columns(w_j) in the input matrix.
\code{b_i, b_j} = numeric vectors, should have length of
#expected number of rows(b_i) / columns(b_j) in input matrix}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-GloVe-fit_transform"></a>}}
\if{latex}{\out{\hypertarget{method-GloVe-fit_transform}{}}}
\subsection{Method \code{fit_transform()}}{
fits model and returns embeddings
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{GloVe$fit_transform(
  x,
  n_iter = 10L,
  convergence_tol = -1,
  n_threads = getOption("rsparse_omp_threads", 1L),
  ...
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{x}}{An input term co-occurence matrix. Preferably in \code{dgTMatrix} format}

\item{\code{n_iter}}{\code{integer} number of SGD iterations}

\item{\code{convergence_tol}}{\code{numeric = -1} defines early stopping strategy. Stop fitting
when one of two following conditions will be satisfied: (a) passed
all iterations (b) \code{cost_previous_iter / cost_current_iter - 1 <
convergence_tol}.}

\item{\code{n_threads}}{number of threads to use}

\item{\code{...}}{not used at the moment}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-GloVe-get_history"></a>}}
\if{latex}{\out{\hypertarget{method-GloVe-get_history}{}}}
\subsection{Method \code{get_history()}}{
returns value of the loss function for each epoch
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{GloVe$get_history()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-GloVe-clone"></a>}}
\if{latex}{\out{\hypertarget{method-GloVe-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{GloVe$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
