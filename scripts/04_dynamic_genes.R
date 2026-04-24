# 04_dynamic_genes.R
# Dynamic gene analysis along fibroblast pseudotime using Monocle3

library(monocle3)

input_file <- "results/fibroblast_monocle3_cds.rds"

if (!file.exists(input_file)) {
  stop("Run scripts/03_trajectory_monocle3.R first.")
}

cds <- readRDS(input_file)

deg_genes <- graph_test(
  cds,
  neighbor_graph = "principal_graph",
  cores = 1
)

deg_genes <- deg_genes[order(deg_genes$q_value), ]

write.csv(
  deg_genes,
  "results/tables/pseudotime_genes_full.csv",
  row.names = TRUE
)

top50_genes <- head(deg_genes, 50)

write.csv(
  top50_genes,
  "results/tables/top50_pseudotime_genes.csv",
  row.names = TRUE
)

message("Dynamic gene analysis complete.")
