# Compares regression, classification and mixed models in terms of output similarity
# Helps to assess models to find most diverse combinations
# See D3 visualization of model and original source code at http://topepo.github.io/caret/similarity.html

tag <- read.csv("tag_data.csv", row.names = 1)
tag <- as.matrix(tag)

## Select only models for regression
regModels <- tag[tag[,"Regression"] == 1,]

all <- 1:nrow(regModels)
## Seed the analysis with the SVM model
start <- grep("(svmRadial)", rownames(regModels), fixed = TRUE)
pool <- all[all != start]

## Select 4 model models by maximizing the Jaccard
## dissimilarity between sets of models
nextMods <- maxDissim(regModels[start,,drop = FALSE],
                      regModels[pool, ],
                      method = "Jaccard",
                      n = 4)

rownames(regModels)[c(start, nextMods)]