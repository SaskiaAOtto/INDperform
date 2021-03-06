% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_clust_sc.R
\name{plot_clust_sc}
\alias{plot_clust_sc}
\title{Dendrogram of the cluster analysis.}
\usage{
plot_clust_sc(x, rotate = FALSE, text_size = 15)
}
\arguments{
\item{x}{Output from the cluster analysis (object of class \code{\link{hclust}}).}

\item{rotate}{If TRUE, rotates plot by 90 degrees.}

\item{text_size}{Size of the title and axes labels.}
}
\value{
The function returns a \code{\link[ggplot2]{ggplot}} object.
}
\description{
\code{plot_clust_sc} generates from the cluster analysis a dendrogram based on
the \code{ggplot2} and \code{ggdendro} packages.
}
\examples{
# Using the Baltic Sea demo data
scores_tbl <- scoring(trend_tbl = model_trend_ex,
  mod_tbl = all_results_ex, press_type = press_type_ex)
scores_mat <- summary_sc(scores_tbl)$scores_matrix
dist_matrix <- dist_sc(scores_mat, method_dist = "euclidean")
clust_analysis <- clust_sc(dist_matrix, method_clust = "complete")
plot_clust_sc(clust_analysis)

# To modify the plot:
plot_clust_sc(clust_analysis, rotate = TRUE, text_size = 20) +
 ggplot2::theme(title = ggplot2::element_text(colour = "blue", size = 10))
}
\seealso{
\code{\link[ggplot2]{ggplot}}, \code{\link[ggdendro]{dendro_data}}
for the data extraction from the \code{hclust} object to produce the dendrogram

Other score-based IND performance functions: 
\code{\link{clust_sc}()},
\code{\link{dist_sc_group}()},
\code{\link{dist_sc}()},
\code{\link{expect_resp}()},
\code{\link{plot_spiechart}()},
\code{\link{scoring}()},
\code{\link{summary_sc}()}
}
\concept{score-based IND performance functions}
