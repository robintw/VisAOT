# Sets up system for ProjectTemplate and loads project

# Load libraries, installing them if not available

# Load DCF file and get list of libraries
d <- read.dcf("config/global.dcf", fields='libraries')

libs = strsplit(d[1,], ',')$libraries

for (lib in libs)
{
  lib = gsub(" ", "", lib)
  if (!require(lib, character.only=TRUE, quietly=TRUE))
  {
    install.packages(lib)
    #require(lib, character.only=TRUE)
  }
}

require(ProjectTemplate) || install.packages("ProjectTemplate")
load.project()