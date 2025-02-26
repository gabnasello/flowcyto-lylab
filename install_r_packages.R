# Set global options
options(unzip = 'internal') # Ensure proper unzip handling
options(install.packages.compile.from.source = 'always') # Compile from source
options(repos = c(CRAN = 'https://ftp.gwdg.de/pub/misc/cran/')) # Set default CRAN mirror

# Update all installed packages
update.packages(ask = FALSE, repos='https://ftp.gwdg.de/pub/misc/cran/')

# Install Cytoverse
remotes::install_github("RGLab/cytoverse", upgrade = "always")
cytoverse::cytoverse_update(upgrades_approved=TRUE)

# Install cytoqc, which is not in Bioconductor
remotes::install_github("RGLab/cytoqc")

# start up for simplified flowcytoscript

# dummy variables for report
experimental.system <- "experimental system"
tissue.type <- "tissue type"
clustering.method <- NULL
p.value.message <- 0
trex.condition <- "None"
total.articles <- 0
fcs.mfi.stats.dir <- "./marker_stats/"
fcs.channel.label <- "None"
analysis.calc.time <- 0
setup.time <- 0
fcs.channel <- NULL
fcs.cluster.label <- NULL
setup.start.time <- Sys.time()

message.delay.time <- 0
Be.Chatty <- TRUE

# Welcome and check R status
if (Be.Chatty == TRUE){
  cat( 
"Welcome to flowcytoscript!\n
This simplified version of the Liston Lab flow cytometry analysis\n
pipeline will try to take care of as much as possible.\n
\n"
  )
  Sys.sleep(message.delay.time)
  cat(  
"We're going to have you tell us what your groups are,\n
which markers you want to analyze, and how many cells\n
you want to work with.\n 
\n"
  )
  Sys.sleep(message.delay.time)
  cat( 
"After that, we'll try to cluster\n
your data, and provide you with visualizations in the forms\n
of tSNE, UMAP, PCA, heatmaps and barcharts.\n
\n"
  )
  Sys.sleep(message.delay.time)
  cat(
"For best results, make sure your R and Rtools are up-to-date.\n
If you can do this yourself, that may work better, particularly\n
for non-Windows users.\n
Alternatively, you can run the flowcytoscript_setup.R script\n
in the source_files folder.\n
\n"
  )
  
  Sys.sleep(message.delay.time)
  
  # check packages, give warning, install missing packages--------------
  
  cat(
"Now we're going to try to install any of the required packages\n
that you don't already have installed.\n
\n"
  )
  Sys.sleep(message.delay.time)
}

required.packages <- c(
  "digest", "dunn.test", "ggplot2", "ggridges", "ggrepel", "ggtext",
  "RColorBrewer", "Rtsne", "uwot", "dplyr", "tidyr", "RcppHNSW",
  "parallel", "data.table", "remotes", "BiocManager", "FastPG",
  "coda", "emmeans", "ConsensusClusterPlus", "flowCore",
  "flowWorkspace", "readxl"
)

cran.packages <- c(
  "digest", "dunn.test", "ggplot2", "ggridges", "ggrepel", "ggtext",
  "RColorBrewer", "Rtsne", "uwot", "dplyr", "tidyr", "RcppHNSW",
  "parallel", "data.table", "remotes", "BiocManager", "coda", "emmeans",
  "readxl"
)

bioconductor.packages <- setdiff(required.packages, cran.packages)

if ( length(setdiff(required.packages, rownames(installed.packages()))) !=0 ){
  cat( "It looks like this might be your first time using flowcytoscript.\n
We need to install some packages before we get started.\n
This might take a few minutes.\n
If you're prompted to update, please do so.\n")
  
  install.packages(setdiff(cran.packages, rownames(installed.packages())), repos = 'http://cran.us.r-project.org')
  
  if ( length(setdiff(bioconductor.packages, rownames(installed.packages()))) !=0 ){
    BiocManager::install("sararselitsky/FastPG")
    BiocManager::install("ConsensusClusterPlus")
  }
  
}


if (length(setdiff(required.packages, rownames(installed.packages()))) !=0 ){
  cat("\n")
  cat("Installation appears to have failed for one or more packages.\n
You'll need to get help before proceeding.\n
      \n")
} else {
  cat("\n")
  cat("That's all done. Now, on to the analysis!\n
      \n")
}

stopifnot("Not all packages were installed" = 
            length(setdiff(required.packages, rownames(installed.packages()))) == 0 )


# Package ‘EmbedSOM’ was removed from the CRAN repository.
#Formerly available versions can be obtained from the archive.
#Archived on 2025-01-10 as issues were not corrected in time.

# Use R Packages Like pak to Avoid GitHub API Rate Limits
install.packages("pak")
pak::pak("exaexa/EmbedSOM")
# Alternative to devtools::install_github('exaexa/EmbedSOM')