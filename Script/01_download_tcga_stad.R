# 01_download_tcga_stad.R
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

if (!requireNamespace("TCGAbiolinks", quietly = TRUE))
  BiocManager::install("TCGAbiolinks")

library(TCGAbiolinks)

query <- GDCquery(
  project       = "TCGA-STAD",
  data.category = "Transcriptome Profiling",
  data.type     = "Gene Expression Quantification",
  workflow.type = "STAR - Counts"
)

dir.create("data/raw", recursive = TRUE, showWarnings = FALSE)
GDCdownload(query, directory = "data/raw")

data <- GDCprepare(query, directory = "data/raw")

dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)
saveRDS(data, "data/processed/tcga_stad_se.rds")

print(data)
dim(data)
table(data$sample_type)
