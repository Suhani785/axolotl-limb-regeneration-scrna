# Axolotl Limb Regeneration scRNA-seq Analysis

## Project Overview

This project investigates transcriptional dynamics during axolotl limb regeneration using single-cell RNA-seq data. The analysis focuses on identifying major cell populations and characterizing fibroblast-associated trajectory changes across regeneration timepoints.

---

## Highlights

- 22 cell populations identified from integrated scRNA-seq dataset 
- Fibroblast trajectory reconstructed using Monocle3 pseudotime 
- Dynamic genes driving regeneration identified using graph_test() 
 
---

## Objective

The goal of this project is to:

- Re-cluster and annotate cell populations from an integrated scRNA-seq dataset
- Identify biologically meaningful cell types
- Focus on fibroblast populations relevant to blastema formation
- Perform trajectory analysis to study cellular progression
- Identify genes dynamically regulated during regeneration

---

## Analysis Workflow

1. Data Input (Integrated Seurat Object)
2. Dimensionality Reduction (PCA → 20 PCs)
3. Clustering (Resolution = 0.6) 
4. Cell Type Annotation 
5. Fibroblast Subsetting
6. Trajectory Inference (Monocle3)
7. Pseudotime Ordering
8. Dynamic Gene Analysis (graph_test)

---

## Dataset

The analysis starts from a post-QC, integrated Seurat object:

all_integrated.rds

Due to file size limitations, the dataset is not included in this repository.

The dataset is derived from previously published axolotl limb regeneration single-cell RNA-seq studies.

**Data Source:**
- Li et al., 2021 – Single-cell analysis of axolotl limb regeneration
- Integrated dataset provided in processed Seurat format

Users should place the dataset in:

data/all_integrated.rds

or reconstruct it from the original raw data using the published pipeline.
---

## Methods

### Clustering (Seurat v5)
- PCA performed with 50 components
- 20 principal components selected
- Clustering resolution = 0.6
- UMAP visualization

### Annotation
- Manual annotation based on marker genes
- 22 clusters identified and biologically classified

### Trajectory Analysis (Monocle3)
- Fibroblast populations used:
  - Fibroblast_ECM_rich
  - Activated_Fibroblast
- Root cells selected from:
  - control
  - 3h timepoints
- Pseudotime ordering performed

### Dynamic Gene Analysis
- Performed using graph_test()
- Genes ranked by q-value
- Top pseudotime genes identified

---

## Key Results

- Identified 22 distinct cell populations
- Characterized fibroblast-driven regeneration trajectory
- Captured pseudotime progression from early to late stages
- Identified dynamic genes associated with regeneration

---

## Key Visualizations

### UMAP Clustering
![UMAP](results/figures/umap_clusters.png)

### Annotated Cell Types
![Annotated UMAP](results/figures/umap_annotated.png)

### Fibroblast Trajectory
![Trajectory](results/figures/trajectory_by_cluster.png)

### Pseudotime Progression
![Pseudotime](results/figures/pseudotime.png)

### Top Dynamic Genes
![Gene Expression](results/figures/top_genes.png)
---

## Repository Structure

axolotl-limb-regeneration-scrna/
├── README.md
├── .gitignore
├── scripts/
│   ├── 01_clustering_seurat.R
│   ├── 02_annotation.R
│   ├── 03_trajectory_monocle3.R
│   └── 04_dynamic_genes.R
├── results/
│   ├── figures/
│   │   ├── umap_clusters.png
│   │   ├── umap_annotated.png
│   │   ├── trajectory_by_cluster.png
│   │   ├── pseudotime.png
│   │   └── top_genes.png
│   └── tables/
│       ├── pseudotime_genes_full.csv
│       ├── top50_pseudotime_genes.csv
│       ├── pseudotime_values.csv
│       └── timepoint_cluster_table.csv
├── data/
│   └── README.md
├── environment/
│   └── (reproducibility information)
└── docs/
    └── (supporting documentation)

---

## How to Reproduce

### 1. Data setup

Place the input Seurat object in:

data/all_integrated.rds

If the file is not available, users may reconstruct it from the original dataset described above.

### 2. Run analysis pipeline

Rscript scripts/01_clustering_seurat.R
Rscript scripts/02_annotation.R
Rscript scripts/03_trajectory_monocle3.R 
Rscript scripts/04_dynamic_genes.R

---

## Tools Used

- R
- Seurat v5
- Monocle3
- ggplot2

---

## Author

Suhani Patel
MS Bioinformatics
Northeastern University
Contact: patel.suhan@northeastern.edu
