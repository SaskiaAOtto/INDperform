#' Distance matrix averaged across group scores
#'
#' The \code{dist_sc_group} function computes a distance matrix for each group of
#' scoring criteria and then averages the pair-wise distances across groups.
#' This allows the computation of a more weighted distance measure and a
#' closer clustering of indicators that e.g. respond to the same pressure types.
#'
#' @param x A list of data frames or matrices that contain the indicator scores
#'   per group (see details). This could be the \code{$scores_matrix} output of
#'   the \code{\link{summary_sc}}, split into the different criteria groups.
#' @param method_dist Dissimilarity index used in the \code{vegdist} function to
#'   to calculate the dissimilarity matrix based on the scores. Default is
#'   `euclidean`, for alternatives see \code{\link[vegan]{vegdist}}.
#' @param ... Further arguments to be passed to the method \code{vegdist}.
#'
#' @details
#' Ordinary distance measures such as the Euclidean, Bray Curtis or Canberra distance
#' treat all variables, i.e. here the criteria, the same, which might be not always desirable.
#' For instance, two indicators that show no trend but respond each to a specific type of
#' fishing pressure (with a score of 1) and a third indicator that only shows a trend (score of 1 here) would
#' have all the same distance to each other. So to add more weight to the similarity of the
#' first two indicators responding to the same pressure type, this function computes separate
#' distance matrices that are then averaged.
#'
#' @return The function returns a \code{\link[stats]{dist}} object.
#'
#' @seealso \code{\link{summary_sc}} and \code{\link[vegan]{vegdist}} for the
#'   computation of the dissimilarity index
#' @family score-based IND performance functions
#'
#' @export
#'
#' @examples
#' # Using the Baltic Sea demo data
#' scores_tbl <- scoring(trend_tbl = model_trend_ex,
#'   mod_tbl = all_results_ex, press_type = press_type_ex)
#' scores_mat <- summary_sc(scores_tbl)$scores_matrix
#' # Split the scores by pressure-independent criteria and pressure types
#' dist_matrix <- dist_sc_group(x = list(
#'  scores_mat[,1:2], scores_mat[,3:8],
#'  scores_mat[,9:12], scores_mat[,13:16]) )
dist_sc_group <- function(x, method_dist = "euclidean", ...) {


  if (!is.list(x) & !is.data.frame(x) & !is.matrix(x)) {
    stop("x is neither a list nor a data frame or matrix!")
  }
  if (is.list(x)) {
    x_dist <- purrr::map(x, vegan::vegdist, method = method_dist, ...)
    dist_mean <- Reduce("+", x_dist)/length(x_dist)
  }
  if (is.data.frame(x) | is.matrix(x)) {
    purrr::map(x, vegan::vegdist, method = method_dist, ...)
    message("The distance matrix is based on one group only!")
  }

  return(dist_mean)

}
