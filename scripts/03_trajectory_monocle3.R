# 03_trajectory_monocle3.R
# Fibroblast-focused trajectory analysis using Monocle3

library(Seurat)
library(monocle3)

input_file <- "results/seurat_annotated.rds"

if (!file.exists(input_file)) {
  stop("Run scripts/02_annotation.R first.")
}

obj <- readRDS(input_file)

fibroblast_labels <- c("Fibroblast_ECM_rich", "Activated_Fibroblast")

fib <- subset(
  obj,
  subset = cell_type %in% fibroblast_labels
)

counts <- GetAssayData(fib, assay = "RNA", layer = "counts")

cell_metadata <- fib@meta.data

gene_metadata <- data.frame(
  gene_short_name = rownames(counts),
  row.names = rownames(counts)
)

cds <- new_cell_data_set(
  counts,
  cell_metadata = cell_metadata,
  gene_metadata = gene_metadata
)

reducedDims(cds)$UMAP <- fib@reductions$umap@cell.embeddings

cds <- cluster_cells(cds, reduction_method = "UMAP")
cds <- learn_graph(cds)

root_cells <- colnames(cds)[cds$orig.ident %in% c("control", "3h")]

cds <- order_cells(cds, root_cells = root_cells)

pdf("results/figures/trajectory_by_cluster.pdf")
plot_cells(
  cds,
  color_cells_by = "cell_type",
  label_groups_by_cluster = FALSE,
  label_leaves = FALSE,
  label_branch_points = FALSE
)
dev.off()

pdf("results/figures/pseudotime_plot.pdf")
plot_cells(
  cds,
  color_cells_by = "pseudotime",
  label_groups_by_cluster = FALSE,
  label_leaves = FALSE,
  label_branch_points = FALSE
)
dev.off()

write.csv(
  data.frame(
    cell = colnames(cds),
    timepoint = cds$orig.ident,
    cell_type = cds$cell_type,
    pseudotime = pseudotime(cds)
  ),
  "results/tables/pseudotime_values.csv",
  row.names = FALSE
)

saveRDS(cds, "results/fibroblast_monocle3_cds.rds")
