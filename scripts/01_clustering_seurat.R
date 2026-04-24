# 01_clustering_seurat.R
# Clustering analysis for axolotl limb regeneration scRNA-seq data

library(Seurat)
library(ggplot2)

set.seed(123)

input_file <- "data/all_integrated.rds"

if (!file.exists(input_file)) {
  stop("Input file not found: data/all_integrated.rds")
}

obj <- readRDS(input_file)

DefaultAssay(obj) <- "integrated"

obj <- RunPCA(obj, npcs = 50, verbose = FALSE)

pdf("results/figures/elbow_plot.pdf")
ElbowPlot(obj, ndims = 50)
dev.off()

obj <- FindNeighbors(obj, dims = 1:20)
obj <- FindClusters(obj, resolution = 0.6)
obj <- RunUMAP(obj, dims = 1:20)

pdf("results/figures/umap_clusters_res0.6.pdf")
DimPlot(obj, reduction = "umap", label = TRUE, repel = TRUE) +
  ggtitle("UMAP Clustering at Resolution 0.6")
dev.off()

markers <- FindAllMarkers(
  obj,
  only.pos = TRUE,
  min.pct = 0.25,
  logfc.threshold = 0.25,
  max.cells.per.ident = 2000
)

write.csv(markers, "results/tables/all_markers.csv", row.names = FALSE)

saveRDS(obj, "results/seurat_clustered_res0.6.rds")
