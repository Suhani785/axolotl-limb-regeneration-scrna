
# 02_annotation.R
# Manual cell-type annotation for clustered Seurat object

library(Seurat)
library(ggplot2)

input_file <- "results/seurat_clustered_res0.6.rds"

if (!file.exists(input_file)) {
  stop("Run scripts/01_clustering_seurat.R first.")
}

obj <- readRDS(input_file)

cluster_annotations <- c(
  "0" = "Fibroblast_ECM_rich",
  "1" = "Macrophage",
  "2" = "Activated_Fibroblast",
  "3" = "Basal_Epithelial",
  "4" = "Epithelial_Subtype",
  "5" = "Unknown_LowConfidence",
  "6" = "RBC_Erythroid",
  "7" = "Neutrophil_Granulocyte",
  "8" = "Epithelial_Pigmentation_Related",
  "9" = "Proliferating_Cells",
  "10" = "Keratinized_Epithelial",
  "11" = "Basement_Membrane_Epithelial",
  "12" = "Mixed_Unclear",
  "13" = "Cartilage_ECM_Specialized",
  "14" = "RBC_Subtype",
  "15" = "Endothelial",
  "16" = "Cartilage_Skeletal_ECM",
  "17" = "Muscle_Myogenic",
  "18" = "Activated_Immune_Macrophage_like",
  "19" = "Mast_Cells",
  "20" = "Platelet_Megakaryocyte_like",
  "21" = "Immune_Lymphoid_like"
)

obj$cell_type <- cluster_annotations[as.character(obj$seurat_clusters)]

annotation_table <- data.frame(
  cluster = names(cluster_annotations),
  cell_type = unname(cluster_annotations)
)

write.csv(
  annotation_table,
  "results/tables/cluster_annotations.csv",
  row.names = FALSE
)

pdf("results/figures/umap_annotated_clean_v2.pdf")
DimPlot(obj, group.by = "cell_type", label = TRUE, repel = TRUE) +
  ggtitle("Annotated Cell Populations")
dev.off()

saveRDS(obj, "results/seurat_annotated.rds")
