% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model_LinearFlow.R
\name{LinearFlow}
\alias{LinearFlow}
\title{Linear-FLow model for one-class collaborative filtering}
\description{
Creates \emph{Linear-FLow} model described in
\href{http://www.bkveton.com/docs/ijcai2016.pdf}{Practical Linear Models for Large-Scale One-Class Collaborative Filtering}.
The goal is to find item-item (or user-user) similarity matrix which is \bold{low-rank and has small Frobenius norm}. Such
double regularization allows to better control the generalization error of the model.
Idea of the method is somewhat similar to \bold{Sparse Linear Methods(SLIM)} but scales to large datasets much better.
}
\examples{
data("movielens100k")
train = movielens100k[1:900, ]
cv = movielens100k[901:nrow(movielens100k), ]
model = LinearFlow$new(
  rank = 10, lambda = 0,
  solve_right_singular_vectors = "svd"
)
user_emb = model$fit_transform(train)
preds = model$predict(cv, k = 10)
}
\references{
\itemize{
  \item{\url{http://www.bkveton.com/docs/ijcai2016.pdf}}
  \item{\url{https://www-users.cse.umn.edu/~ningx005/slides/ICDM2011_slides.pdf}}
}
}
\section{Super class}{
\code{\link[rsparse:MatrixFactorizationRecommender]{rsparse::MatrixFactorizationRecommender}} -> \code{LinearFlow}
}
\section{Public fields}{
\if{html}{\out{<div class="r6-fields">}}
\describe{
\item{\code{v}}{right singular vector of the user-item matrix. Size is \code{n_items * rank}.
In the paper this matrix is called \bold{v}}
}
\if{html}{\out{</div>}}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-LinearFlow-new}{\code{LinearFlow$new()}}
\item \href{#method-LinearFlow-fit_transform}{\code{LinearFlow$fit_transform()}}
\item \href{#method-LinearFlow-transform}{\code{LinearFlow$transform()}}
\item \href{#method-LinearFlow-cross_validate_lambda}{\code{LinearFlow$cross_validate_lambda()}}
\item \href{#method-LinearFlow-clone}{\code{LinearFlow$clone()}}
}
}
\if{html}{\out{
<details open><summary>Inherited methods</summary>
<ul>
<li><span class="pkg-link" data-pkg="rsparse" data-topic="MatrixFactorizationRecommender" data-id="predict"><a href='../../rsparse/html/MatrixFactorizationRecommender.html#method-MatrixFactorizationRecommender-predict'><code>rsparse::MatrixFactorizationRecommender$predict()</code></a></span></li>
</ul>
</details>
}}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-LinearFlow-new"></a>}}
\if{latex}{\out{\hypertarget{method-LinearFlow-new}{}}}
\subsection{Method \code{new()}}{
creates Linear-FLow model with \code{rank} latent factors.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{LinearFlow$new(
  rank = 8L,
  lambda = 0,
  init = NULL,
  preprocess = identity,
  solve_right_singular_vectors = c("soft_impute", "svd")
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{rank}}{size of the latent dimension}

\item{\code{lambda}}{regularization parameter}

\item{\code{init}}{initialization of the orthogonal basis.}

\item{\code{preprocess}}{\code{identity()} by default. User spectified function which will
be applied to user-item interaction matrix before running matrix factorization
(also applied during inference time before making predictions).
For example we may want to normalize each row of user-item matrix to have 1 norm.
Or apply \code{log1p()} to discount large counts.}

\item{\code{solve_right_singular_vectors}}{type of the solver for initialization of the orthogonal
basis. Original paper uses SVD. See paper for details.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-LinearFlow-fit_transform"></a>}}
\if{latex}{\out{\hypertarget{method-LinearFlow-fit_transform}{}}}
\subsection{Method \code{fit_transform()}}{
performs matrix factorization
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{LinearFlow$fit_transform(x, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{x}}{input matrix}

\item{\code{...}}{not used at the moment}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-LinearFlow-transform"></a>}}
\if{latex}{\out{\hypertarget{method-LinearFlow-transform}{}}}
\subsection{Method \code{transform()}}{
calculates user embeddings for the new input
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{LinearFlow$transform(x, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{x}}{input matrix}

\item{\code{...}}{not used at the moment}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-LinearFlow-cross_validate_lambda"></a>}}
\if{latex}{\out{\hypertarget{method-LinearFlow-cross_validate_lambda}{}}}
\subsection{Method \code{cross_validate_lambda()}}{
performs fast tuning of the parameter `lambda` with warm re-starts
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{LinearFlow$cross_validate_lambda(
  x,
  x_train,
  x_test,
  lambda = "auto@10",
  metric = "map@10",
  not_recommend = x_train,
  ...
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{x}}{input user-item interactions matrix. Model performs matrix facrtorization based
only on this matrix}

\item{\code{x_train}}{user-item interactions matrix. Model recommends items based on this matrix.
Usually should be different from `x` to avoid overfitting}

\item{\code{x_test}}{target user-item interactions. Model will evaluate predictions against this
matrix, `x_test` should be treated as future interactions.}

\item{\code{lambda}}{numeric vector - sequaence of regularization parameters. Supports special
value like `auto@10`. This will automatically fine a sequence of lambda of length 10. This
is recommended way to check for `lambda`.}

\item{\code{metric}}{a metric against which model will be evaluated for top-k recommendations.
Currently only \code{map@k} and \code{ndcg@k} are supported (\code{k} can be any integer)}

\item{\code{not_recommend}}{matrix same shape as `x_train`. Specifies which items to not recommend
for each user.}

\item{\code{...}}{not used at the moment}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-LinearFlow-clone"></a>}}
\if{latex}{\out{\hypertarget{method-LinearFlow-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{LinearFlow$clone(deep = FALSE)}\if{html}{\out{</div>}}
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
