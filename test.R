# 克隆 ----------------------------------------------------------------------
system("git clone https://github.com/Yunuuuu/faers.git faers_src")
setwd("~/projects/test/faers_src")
usethis::proj_activate(".")    # 把 RStudio Project 设为当前
devtools::load_all()
# 下载与标准化 ----------------------------------------------------------------------
library(faers)
faers_meta(force=TRUE)
data1<-faers(2021,"q1",dir = "~/projects/test/data",compress_dir ="~/projects/test/data")

data2<-faers(2018,"q1",dir = "~/projects/test/data",compress_dir ="~/projects/test/data")
faers_get(data1, "demo")
#需要meddra原始数据
meddra_path<-"~/projects/test/meddra_26.0"
data1 <- faers_standardize(data1,meddra_path)
faers_meddra(data1)
faers_meddra(data1, use = "hierarchy")
faers_get(data1, "indi")
faers_get(data1, "reac")
data1 <- faers_dedup(data1)

# 药物警戒分析 ------------------------------------------------------------------
insulin_names <- "insulin"
insulin_pattern <- paste(insulin_names, collapse = "|")
fda_insulin <- fda_drugs()[
  grepl(insulin_pattern, ActiveIngredient, ignore.case = TRUE)
]####
